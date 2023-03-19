//
//  MovieItemWrapper.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import Foundation
import SwiftUI
import TMDb
import CoreData

struct MovieItemWrapper: View {
    @Environment(\.tmdb) var tmdb
    @EnvironmentObject var store: Store
    @Environment(\.managedObjectContext) var context
    let displayType: DisplayType
    let movie: Movie?
    @FetchRequest(entity: FavoriteMovie.entity(), sortDescriptors: [.init(key: "createTimestamp", ascending: false)])
    var favoriteMovies:FetchedResults<FavoriteMovie>

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
                store.send(.updateMovieWishlisth($0))
            }
        )

    }
}

#if DEBUG
    struct MovieItemWrapperPreview: PreviewProvider {
        static var previews: some View {
            MovieItemWrapper(displayType: .portrait(.middle), movie: PreviewData.previewMovie)
                .environmentObject(Store())
            MovieItemWrapper(displayType: .landscape, movie: PreviewData.previewMovie)
                .environmentObject(Store())
            
            MovieItemWrapper(displayType: .portrait(.middle), movie: nil)
                .environmentObject(Store())
        }
    }
#endif
