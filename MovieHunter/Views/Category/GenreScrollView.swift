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
    @State private var movies = [Movie]()
    @Environment(\.tmdb) private var tmdb

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                if movies.isEmpty {
                    MovieItem(
                        movie: nil,
                        category: .genre(genreID),
                        displayType: .portrait(.small)
                    )
                }
                ForEach(movies) { movie in
                    MovieItem(
                        movie: movie,
                        genreID: genreID,
                        displayType: .portrait(.small)
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
            if let result = try? await tmdb.discover.movies(sortedBy: nil, withPeople: nil, withGenres: [genreID], includeAdult: false, page: 1) {
                movies = Array(result.results.prefix(10))
            }
        }
    }
}

#if DEBUG
    struct GenreScrollView_Previews: PreviewProvider {
        static var previews: some View {
            GenreScrollView(genreID: 12)
        }
    }
#endif
