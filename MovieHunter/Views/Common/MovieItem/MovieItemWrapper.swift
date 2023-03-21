//
//  MovieItemWrapper.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import CoreData
import Foundation
import SwiftUI
import TMDb

struct MovieItemWrapper: View {
    @Environment(\.tmdb) var tmdb
    @EnvironmentObject var store: Store
    @Environment(\.managedObjectContext) var context
    let displayType: DisplayType
    let movie: Movie?
    let goDetail: (Movie) -> Void
    @FetchRequest(entity: FavoriteMovie.entity(), sortDescriptors: [.init(key: "createTimestamp", ascending: false)])
    var favoriteMovies: FetchedResults<FavoriteMovie>

    var inWishlist: Bool {
        guard let movie else { return false }
        return store.inWishlist(movie.id)
    }

    var body: some View {
        MovieItem(
            movie: movie,
            inWishlist: inWishlist,
            displayType: displayType,
            updateWishlist: {
                store.send(.updateMovieWishlist($0))
            },
            goDetail: goDetail
        )
    }
}

#if DEBUG
    struct MovieItemWrapperPreview: PreviewProvider {
        static var previews: some View {
            MovieItemWrapper(
                displayType: .portrait(.middle),
                movie: PreviewData.previewMovie1,
                goDetail: { print($0) }
            )
            .environmentObject(Store())
            MovieItemWrapper(
                displayType: .landscape,
                movie: PreviewData.previewMovie1,
                goDetail: { print($0) }
            )
            .environmentObject(Store())

            MovieItemWrapper(
                displayType: .portrait(.middle),
                movie: nil,
                goDetail: { print($0) }
            )
            .environmentObject(Store())
        }
    }
#endif
