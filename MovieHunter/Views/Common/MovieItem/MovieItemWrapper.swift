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
    let movie: Movie?
    let category: Category?
    let genreID: Genre.ID?
    let displayType: DisplayType

    @Environment(\.tmdb) private var tmdb
    @EnvironmentObject private var store: Store
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(entity: FavoriteMovie.entity(), sortDescriptors: [.init(key: "createTimestamp", ascending: false)])
    private var favoriteMovies: FetchedResults<FavoriteMovie>
    private var inWishlist: Bool {
        guard let movie else { return false }
        return store.inWishlist(movie.id)
    }

    init(
        movie: Movie?,
        category: Category? = nil,
        genreID: Genre.ID? = nil,
        displayType: DisplayType
    ) {
        self.movie = movie
        self.category = category
        self.genreID = genreID
        self.displayType = displayType
    }

    var body: some View {
        MovieItem(
            movie: movie,
            category: category,
            genreID: genreID,
            displayType: displayType
        )
    }
}

// #if DEBUG
//    struct MovieItemWrapperPreview: PreviewProvider {
//        static var previews: some View {
//            MovieItemWrapper(
//                displayType: .portrait(.middle),
//                movie: PreviewData.previewMovie1,
//                goDetail: { print($0) }
//            )
//            .environmentObject(Store())
//            MovieItemWrapper(
//                displayType: .landscape,
//                movie: PreviewData.previewMovie1,
//                goDetail: { print($0) }
//            )
//            .environmentObject(Store())
//
//            MovieItemWrapper(
//                displayType: .portrait(.middle),
//                movie: nil,
//                goDetail: { print($0) }
//            )
//            .environmentObject(Store())
//        }
//    }
// #endif
