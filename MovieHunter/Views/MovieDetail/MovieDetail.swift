//
//  MovieDetail.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI
import TMDb

struct MovieDetail: View {
    let movie: Movie
    @Environment(\.deviceStatus) private var deviceStatus
    @Environment(\.tmdb) private var tmdb
    @State private var reviews = [Review]()
    private var compact: Bool {
        deviceStatus == .compact
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                MovieHeader(movie: movie)
                DetailCredit(movie: movie)
                if !reviews.isEmpty {
                    DetailReviews(reviews: reviews)
                }
                MovieSpecific(movie: movie)
                SimilarMovies(movie: movie)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Assets.Colors.mainBackground)
        .task {
            if let reviews = try? await tmdb.movies.reviews(forMovie: movie.id, page: 1) {
                self.reviews = reviews.results
            }
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: PreviewData.previewMovie1)
    }
}
