//
//  GenreContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/21.
//

import Foundation
import SwiftUI
import TMDb

struct GenreContainer: View {
    let genreID:Int
    let inWishlist: (Int) -> Bool
    let goDetail: (Movie) -> Void
    let updateWishlist: (Int) -> Void
    let goCategory: (Destination) -> Void
    
    var genreTitle:LocalizedStringKey {
        Genres(rawValue: genreID)?.localizedString ?? ""
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ViewMoreButton(
                title: genreTitle
//                perform: {  }
            )
            GenreScrollView(
                genreID: genreID,
                inWishlist: inWishlist,
                goDetail: goDetail,
                updateWishlist: updateWishlist
            )
        }
        .background(Assets.Colors.rowBackground)
        .frame(maxWidth: .infinity)
    }
}

//struct GenreContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        GenreContainer()
//    }
//}
