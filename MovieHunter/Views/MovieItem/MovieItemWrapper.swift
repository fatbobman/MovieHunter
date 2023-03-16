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
    let displayType:DisplayType
    let movie: Movie
    var body: some View {
        MovieItem(
            movieID: movie.id,
            movieName: movie.title,
            imageURL: posterPath,
            rate: movie.voteAverage,
            duration: movie.runtime ?? 90,
            releaseDate: movie.releaseDate,
            inWishlist: true,
            displayType: displayType,
            updateWishlist: { _ in }
        )
    }

    var posterPath: URL? {
        guard let path = movie.posterPath else { return nil }
        return moviePosterURLPrefix.appending(path:path.absoluteString)
    }
}

#if DEBUG
struct MovieItemWrapperPreview:PreviewProvider {
    static var previews: some View {
        MovieItemWrapper(displayType: .portrait(.small), movie: PreviewData.previewMovie)
            .environment(\.locale, .init(identifier: "zh-cn"))
    }
}
#endif
