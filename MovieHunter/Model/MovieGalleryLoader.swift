//
//  MovieGalleryLoader.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/24.
//

import Foundation
import SwiftUI
import TMDb

final class MoviesGalleryLoader: RandomAccessCollection, ObservableObject {
    @Published var movies = [Movie]()

    @AppStorage("genre_sortBy") private var genre_sortBy: Genre_SortBy = .byPopularity
    private var category: Category? = nil
    private var tmdb: TMDbAPI? = nil
    private var currentPage: Int = 1
    private var finished = false
    private var loading = false
    private let maxPage = 10
    private var loader: ((Int) async throws -> PageableListResult<Movie>)?

    func formIndex(after i: inout Int) {
        i += 1
        if i == movies.count - 1,!loading,!finished, currentPage < maxPage {
            Task {
                await loadNextPage()
            }
        }
    }

    func loadNextPage() async {
        if !finished,!loading, let loader {
            loading = true
            if let result = await withErrorHandling({ () -> PageableListResult<Movie> in
                try await loader(self.currentPage)
            }) {
                await MainActor.run {
                    movies += result.results
                    if let totalPages = result.totalPages, currentPage < Swift.min(totalPages, maxPage) {
                        currentPage += 1
                    } else {
                        finished = true
                    }
                }
            }
            loading = false
        }
    }

    var startIndex: Int {
        movies.startIndex
    }

    var endIndex: Int {
        movies.endIndex
    }

    subscript(position: Int) -> Movie {
        movies[position]
    }

    func setLoader(category: Category, tmdb: TMDbAPI) {
        guard self.tmdb == nil, self.category == nil else { return }
        self.tmdb = tmdb
        self.category = category
        let loaders = Loaders()
        var loader: ((Int) async throws -> PageableListResult<Movie>)? = nil
        switch category {
        case .nowPlaying:
            loader = { try await loaders.nowPlaying(tmdb, $0) }
        case .popular:
            loader = { try await loaders.popular(tmdb, $0) }
        case .upComing:
            loader = { try await loaders.upComing(tmdb, $0) }
        case .topRate:
            loader = { try await loaders.topRate(tmdb, $0) }
        case let .genre(genreID):
            loader = { try await loaders.genre(tmdb, self.genre_sortBy.movieSort, genreID, $0) }
        default:
            break
        }
        self.loader = loader
        Task {
            await loadNextPage()
        }
    }
}

extension MoviesGalleryLoader {
    private struct Loaders {
        let nowPlaying: (TMDbAPI, Int) async throws -> PageableListResult<Movie> = { tmdb, page in
            try await tmdb.movies.nowPlaying(page: page)
        }

        let popular: (TMDbAPI, Int) async throws -> PageableListResult<Movie> = { tmdb, page in
            try await tmdb.movies.popular(page: page)
        }

        let upComing: (TMDbAPI, Int) async throws -> PageableListResult<Movie> = { tmdb, page in
            try await tmdb.movies.upcoming(page: page)
        }

        let topRate: (TMDbAPI, Int) async throws -> PageableListResult<Movie> = { tmdb, page in
            try await tmdb.movies.topRated(page: page)
        }

        let genre: (TMDbAPI, MovieSort, Genre.ID, Int) async throws -> PageableListResult<Movie> = { tmdb, sort, genreID, page in
            try await tmdb.discover.movies(sortedBy: sort, withPeople: nil, withGenres: [genreID], page: page)
        }
    }
}
