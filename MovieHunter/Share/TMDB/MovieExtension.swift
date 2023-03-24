//
//  MovieExtension.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/24.
//

import Foundation
import TMDb

extension Movie {
    /// get movie from tmdb by wishlist ids
    static func loadWishlistMovieByIDs(tmdb: TMDbAPI, movieIDs: [Movie.ID]) async -> [Movie] {
        let movies = await withTaskGroup(of: Movie?.self, returning: [Movie?].self) { taskGroup in
            for movieID in movieIDs {
                taskGroup.addTask {
                    try? await tmdb.movies.details(forMovie: movieID)
                }
            }
            var movies = [Movie?]()
            for await result in taskGroup {
                movies.append(result)
            }
            return movies
        }
        return movies.compactMap { $0 }.sorted(using: KeyPathComparator(\.popularity))
    }
}
