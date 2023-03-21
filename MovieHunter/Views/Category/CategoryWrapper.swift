//
//  CategoryWrapper.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import SwiftUI
import TMDb

struct CategoryWrapper: View {
    @EnvironmentObject private var store: Store
    let category: Category
    var body: some View {
        switch category {
        case .nowPlaying:
            NowPlayingRowContainer(
                inWishlist: inWishlist,
                goDetail: goDetail,
                updateWishlist: updateWishlist,
                goCategory: goCategory
            )
        case .popular:
            CategoryCommonContainer(
                category: .popular,
                inWishlist: inWishlist,
                goDetail: goDetail,
                updateWishlist: updateWishlist,
                goCategory: goCategory
            )
        case .upComing:
            CategoryCommonContainer(
                category: .upComing,
                inWishlist: inWishlist,
                goDetail: goDetail,
                updateWishlist: updateWishlist,
                goCategory: goCategory
            )
        case .topRate:
            CategoryCommonContainer(
                category: .topRate,
                inWishlist: inWishlist,
                goDetail: goDetail,
                updateWishlist: updateWishlist,
                goCategory: goCategory
            )
        case .movieWishlist:
            WishlistContainer(
                inWishlist: inWishlist,
                goDetail: goDetail,
                updateWishlist: updateWishlist,
                goCategory: goCategory
            )
        case .favoritePerson:
            Text("fa")
        }
    }

    var inWishlist: (Int) -> Bool {
        { store.state.favoriteMovieIDs.contains($0) }
    }

    var goDetail: (Movie) -> Void {
        { store.send(.setDestination(to: [.nowPlaying, .movieDetail($0)])) }
    }

    var updateWishlist: (Int) -> Void {
        { store.send(.updateMovieWishlist($0)) }
    }

    var goCategory: (Destination) -> Void {
        { store.send(.setDestination(to: [$0])) }
    }
}

struct CategoryRoot_Previews: PreviewProvider {
    static var previews: some View {
        CategoryWrapper(category: .nowPlaying)
            .environmentObject(Store.share)
    }
}
