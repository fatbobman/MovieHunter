//
//  GenreScrollView.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/21.
//

import Foundation
import SwiftUI
import TMDb

struct GenreScrollView: View {
    let genreID: Int
    let inWishlist: (Int) -> Bool
    let goDetail: (Movie) -> Void
    let updateWishlist: (Int) -> Void
    @State private var movies = [Movie]()
    @Environment(\.tmdb) private var tmdb
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(movies) { movie in
                    MovieItemWrapper(
                        movie: movie,
                        genreID: genreID,
                        displayType: .portrait(.small)
//                        goDetail: goDetail
                    )
                }
            }
            .padding(.bottom, 22)
        }
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .leading) {
            Color.clear
                .frame(width: 6)
        }
        .safeAreaInset(edge: .trailing) {
            Color.clear
                .frame(width: 6)
        }
        .task {
            if let result = try? await tmdb.discover.movies(sortedBy: nil, withPeople: nil, withGenres: [genreID], page: 1) {
                movies = Array(result.results.prefix(10))
            }
        }
    }
}

struct GenreScrollView_Previews: PreviewProvider {
    static var previews: some View {
        GenreScrollView(
            genreID: 12,
            inWishlist: { _ in true },
            goDetail: { print($0) },
            updateWishlist: { print($0) }
        )
    }
}
