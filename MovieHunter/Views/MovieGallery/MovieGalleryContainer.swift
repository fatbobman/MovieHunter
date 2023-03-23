//
//  MovieGalleryContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/23.
//

import Foundation
import SwiftUI
import TMDb

struct MovieGalleryContainer: View {
    let category: Category

    @Environment(\.deviceStatus) private var deviceStatus
    @Environment(\.tmdb) private var tmdb
    @StateObject private var loader = MoviesGalleryLoader()

    init(category: Category) {
        self.category = category
    }

    private var showInGrid: Bool {
        switch deviceStatus {
        case .compact:
            return false
        default:
            return true
        }
    }

    var body: some View {
        List {
            ForEach(loader) { movie in
                MovieItem(movie: movie, displayType: .landscape)
            }
        }
        .onAppear {
            loader.setLoader(category: category, tmdb: tmdb)
        }
    }
}

struct MovieGalleryContainer_Previews: PreviewProvider {
    static var previews: some View {
        MovieGalleryContainer(category: .topRate)
    }
}

final class MoviesGalleryLoader: RandomAccessCollection, ObservableObject {
    // TODO: 读取顺序 AppStorage
    @Published var movies = [Movie]()
    private var category: Category? = nil
    private var tmdb: TMDbAPI? = nil
    private var currentPage: Int = 1
    private var finished = false
    private var loading = false
    private let maxPage = 10

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
                try await tmdb.discover.movies(sortedBy: .popularity(), withPeople: nil, withGenres: [genreID], page: $0)
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
