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
    let category: Category
    var body: some View {
        switch category {
        case .nowPlaying:
            NowPlayingRowContainer()
        case .popular:
            CategoryCommonContainer(category: .popular)
        case .upComing:
            CategoryCommonContainer(category: .upComing)
        case .topRate:
            CategoryCommonContainer(category: .topRate)
        case .movieWishlist:
            WishlistContainer()
        default:
            EmptyView()
        }
    }
}

#if DEBUG
    struct CategoryRoot_Previews: PreviewProvider {
        static var previews: some View {
            CategoryWrapper(category: .nowPlaying)
                .environmentObject(Store.share)

            CategoryWrapper(category: .nowPlaying)
                .environmentObject(Store.share)
                .environment(\.deviceStatus, .regular)
                .previewDevice(PreviewDevice(rawValue: "iPad Pro 11'"))
                .previewInterfaceOrientation(.landscapeLeft)

            CategoryWrapper(category: .popular)
                .environmentObject(Store.share)
        }
    }
#endif
