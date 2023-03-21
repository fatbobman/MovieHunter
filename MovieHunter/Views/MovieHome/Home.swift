//
//  Home.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import SwiftUI

struct Home: View {
    @EnvironmentObject var store: Store
    var genres: [Genres] {
        Genres
            .allCases
            .filter { store.state.configuration.genres.contains($0.id)
            }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(Category.allCases) { category in
                    CategoryWrapper(category: category)
                }
                // TODO: 根据设定过过滤
                ForEach(genres) { genre in
                    GenreContainer(genreID: genre.id, inWishlist: { _ in true }, goDetail: { _ in }, updateWishlist: {_ in}, goCategory: {_ in})
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Assets.Colors.mainBackground)
    }
}

struct HomeRoot_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(Store.share)
    }
}
