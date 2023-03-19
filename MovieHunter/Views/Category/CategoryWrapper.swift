//
//  CategoryWrapper.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import SwiftUI

struct CategoryWrapper: View {
    let category:Category
    var body: some View {
        switch category {
        case .nowPlaying:
            let _ = print("abc")
            MovieNowPlayingContainer()
        case .popular:
            Text("popu")
        case .upComing:
            Text("up")
        case .topRate:
            Text("rate")
        case .movieWishlist:
            Text("list")
        case .favoritePerson:
            Text("fa")
        }
    }
}

struct CategoryRoot_Previews: PreviewProvider {
    static var previews: some View {
        CategoryWrapper(category: .favoritePerson)
    }
}
