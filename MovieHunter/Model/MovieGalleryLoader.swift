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

    private var movieSort: MovieSort {
        switch genre_sortBy {
        case .byPopularity:
            return .popularity()
        case .byVoteAverage:
            return .voteAverage()
        case .byReleaseDate:
            return .releaseDate()
        }
    }

    var loader: ((Int) async throws -> PageableListResult<Movie>)?

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
            do {
                let result = try await Task {
                    try await loader(currentPage)
                }.value
                await MainActor.run {
                    movies += result.results
                    if let totalPages = result.totalPages, currentPage < Swift.min(totalPages, maxPage) {
                        currentPage += 1
                    } else {
                        finished = true
                    }
                }
            } catch {
                #if DEBUG
                    print(error)
                #endif
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
        return movies[position]
    }

    func setLoader(category: Category, tmdb: TMDbAPI) {
        guard self.tmdb == nil, self.category == nil else { return }
        self.tmdb = tmdb
        self.category = category

        var loader: ((Int) async throws -> PageableListResult<Movie>)? = nil
        switch category {
        case .nowPlaying:
            loader = {
                try await tmdb.movies.nowPlaying(page: $0)
            }
        case .popular:
            loader = {
                try await tmdb.movies.popular(page: $0)
            }
        case .upComing:
            loader = {
                try await tmdb.movies.upcoming(page: $0)
            }
        case .topRate:
            loader = {
                try await tmdb.movies.topRated(page: $0)
            }
        case let .genre(genreID):
            loader = {
                try await tmdb.discover.movies(sortedBy: self.movieSort, withPeople: nil, withGenres: [genreID], page: $0)
            }
        default:
            break
        }
        self.loader = loader
        Task {
            await loadNextPage()
        }
    }
}
