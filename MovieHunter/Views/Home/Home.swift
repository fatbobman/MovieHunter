//
//  Home.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import SwiftUI

struct HomeRoot: View {
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
                ForEach(genres, id: \.id) { genre in
                    Text(genre.localizedString)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Assets.Colors.mainBackground)
    }
}

struct HomeRoot_Previews: PreviewProvider {
    static var previews: some View {
        HomeRoot()
            .environmentObject(Store.share)
    }
}
