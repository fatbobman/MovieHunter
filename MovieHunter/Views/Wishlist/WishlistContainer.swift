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
    @EnvironmentObject private var store: Store
    @State private var showEmpty: Bool = true
    var body: some View {
        VStack(spacing: 0) {
            ViewMoreButton(title: Category.movieWishlist.localizedString)
            WishlistScrollView()
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

#if DEBUG
    struct WishlistContainer_Previews: PreviewProvider {
        static var previews: some View {
            WishlistContainer()
                .environmentObject(Store.share)
        }
    }
#endif
