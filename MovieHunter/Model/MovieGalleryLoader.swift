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
    @Published var loading = false
    private var category: Category? = nil
    private var tmdb: TMDbAPI? = nil
    private var currentPage: Int = 1
    private var finished = false
    private let maxPage = 10
    private var loader: ((Int) async throws -> PageableListResult<Movie>)?
    private let genre_sortBy: Genre_SortBy = .byPopularity
    private let showAdultMovieInResult = false

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
            await MainActor.run {
                loading = true
            }
            if let result = await withErrorHandling({ () -> PageableListResult<Movie> in
                try await loader(self.currentPage)
            }) {
                await MainActor.run {
                    // TMDB 数据库有时会将相同的 MovieID，返回多个 Copy，这样会造成 ForEach 显示问题（ 以 movieID 为标识符）
                    // 在此处做一下去重处理
                    let tempMovies = movies + result.results
                    movies = tempMovies.uniqueMovie()
                    if let totalPages = result.totalPages, currentPage < Swift.min(totalPages, maxPage) {
                        currentPage += 1
                    } else {
                        finished = true
                    }
                }
            }
            await MainActor.run {
                loading = false
            }
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
        loader = makeLoader(category: category, tmdb: tmdb)
        Task {
            await loadNextPage()
        }
    }

    func makeLoader(category: Category, tmdb: TMDbAPI) -> ((Int) async throws -> PageableListResult<Movie>)? {
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
            loader = { try await loaders.genre(tmdb, self.genre_sortBy.movieSort, genreID, self.showAdultMovieInResult, $0) }
        default:
            break
        }
        return loader
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

        let genre: (TMDbAPI, MovieSort, Genre.ID, Bool, Int) async throws -> PageableListResult<Movie> = { tmdb, sort, genreID, includeAdult, page in
            try await tmdb.discover.movies(sortedBy: sort, withPeople: nil, withGenres: [genreID], includeAdult: includeAdult, page: page)
        }
    }
}
