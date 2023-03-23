//
//  CategoryCommon.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/20.
//

import Foundation
import SwiftUI
import TMDb

struct CategoryCommonContainer: View {
    let category: Category
//    let inWishlist: (Int) -> Bool
//    let goDetail: (Movie) -> Void
//    let updateWishlist: (Int) -> Void
//    let goCategory: (Destination) -> Void
    var body: some View {
        VStack(spacing: 0) {
            ViewMoreButton(
                title: category.localizedString
//                perform: { goCategory(category.destination) }
            )
            CategoryCommonScrollView(
                category: category
//                inWishlist: inWishlist,
//                goDetail: goDetail,
//                updateWishlist: updateWishlist
            )
        }
        .background(Assets.Colors.rowBackground)
        .frame(maxWidth: .infinity)
    }
}

//struct CategoryCommonContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryCommonContainer(
//            category: .popular,
//            inWishlist: { _ in true },
//            goDetail: { print($0) },
//            updateWishlist: { print($0) },
//            goCategory: { print($0) }
//        )
//    }
//}
