//
//  WishlistContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/20.
//

import Foundation
import SwiftUI
import TMDb

struct WishlistContainer: View {
//    let inWishlist: (Int) -> Bool
//    let goDetail: (Movie) -> Void
//    let updateWishlist: (Int) -> Void
//    let goCategory: (Destination) -> Void

    @EnvironmentObject private var store: Store
    @State private var showEmpty: Bool = true
    var body: some View {
        VStack(spacing: 0) {
            ViewMoreButton(
                title: Category.movieWishlist.localizedString
//                perform: { goCategory(.wishlist) }
            )
            WishlistScrollView(
//                inWishlist: inWishlist,
//                goDetail: goDetail,
//                updateWishlist: updateWishlist
            )
            .overlay(
                VStack {
                    if showEmpty {
                        WishlistEmpty()
                    }
                }
                .animation(.default, value: showEmpty)
            )
        }

        .task(id: store.state.favoriteMovieIDs.count) {
            if store.state.favoriteMovieIDs.isEmpty {
                showEmpty = true
            } else {
                showEmpty = false
            }
        }
    }
}

struct WishlistContainer_Previews: PreviewProvider {
    static var previews: some View {
        WishlistContainer(
//            inWishlist: { _ in true },
//            goDetail: { print($0) },
//            updateWishlist: { print($0) },
//            goCategory: { print($0) }
        )
        .environmentObject(Store.share)
    }
}
