//
//  ReleateMovies.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI
import TMDb

struct SimilarMovies: View {
    let movie: Movie
    @Environment(\.tmdb) private var tmdb
    @State private var movies = [Movie]()
    var body: some View {
        DetailRow(title: "Detail_MoreLikeThis_Label") {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    if movies.isEmpty {
                        MovieItem(movie: nil, displayType: .portrait(.small))
                    }
                    ForEach(movies) { movie in

                        MovieItem(movie: movie, displayType: .portrait(.small))
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .task {
            if let movies = try? await tmdb.movies.similar(toMovie: movie.id, page: 1).results {
                self.movies = movies
            }
        }
    }
}

struct SimilarMovies_Previews: PreviewProvider {
    static var previews: some View {
        SimilarMovies(movie: .previewMovie1)
    }
}
