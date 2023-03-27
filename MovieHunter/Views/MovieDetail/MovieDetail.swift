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
    private var compact: Bool {
        deviceStatus == .compact
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                MovieHeader(movie: movie)
                DetailCredit(movie: movie)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Assets.Colors.mainBackground)
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movie: PreviewData.previewMovie1)
    }
}
