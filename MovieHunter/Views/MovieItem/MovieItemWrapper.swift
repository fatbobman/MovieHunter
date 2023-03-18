//
//  MovieItemWrapper.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import Foundation
import SwiftUI
import TMDb

struct MovieItemWrapper: View {
    @Environment(\.tmdb) var tmdb
    @EnvironmentObject var store: Store
    let displayType: DisplayType
    let movie: Movie

    var inWishlist: Bool { store.state.favorite.movies.contains(movie.id)
    }

    var body: some View {
        MovieItem(
            movieID: movie.id,
            movieName: movie.title,
            imageURL: posterPath,
            rate: movie.voteAverage,
            duration: movie.runtime ?? 90,
            releaseDate: movie.releaseDate,
            inWishlist: inWishlist,
            displayType: displayType,
            updateWishlist: {
                store.send(.updateMovieWishlisth($0))
            }
        )
    }

    var posterPath: URL? {
        guard let path = movie.posterPath else { return nil }
        return moviePosterURLPrefix.appending(path: path.absoluteString)
    }
}

#if DEBUG
    struct MovieItemWrapperPreview: PreviewProvider {
        static var previews: some View {
            MovieItemWrapper(displayType: .portrait(.middle), movie: PreviewData.previewMovie)
                .environment(\.locale, .init(identifier: "zh-cn"))
                .environmentObject(Store())
            MovieItemWrapper(displayType: .landscape, movie: PreviewData.previewMovie)
                .environment(\.locale, .init(identifier: "zh-cn"))
                .environmentObject(Store())
        }
    }
#endif
