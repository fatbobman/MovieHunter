//
//  Home.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import SwiftUI

struct Home: View {
    @StateObject var configuration = AppConfiguration()
    var genres: [Genres] {
        Genres
            .allCases
            .filter { configuration.genres.contains($0.id)
            }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(Category.showableCategory) { category in
                    CategoryWrapper(category: category)
                }
                // TODO: 根据设定过过滤
                ForEach(genres) { genre in
                    GenreContainer(genreID: genre.id)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Assets.Colors.mainBackground)
        #if !os(macOS)
            .toolbar(.hidden, for: .navigationBar)
        #endif
    }
}

#if DEBUG
    struct HomeRoot_Previews: PreviewProvider {
        static var previews: some View {
            Home()
                .environmentObject(Store.share)
        }
    }
#endif
