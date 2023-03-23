//
//  MovieBannerTitle.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI
import TMDb

struct NowPlayingBannerTitle: View {
    let movie: Movie
    var body: some View {
        VStack(alignment: .leading) {
            Text(movie.title)
                .font(.footnote)
                .lineLimit(1)
            Group {
                if let releaseDate = movie.releaseDate {
                    Text(releaseDate, format: .dateTime.month().day())

                } else if let overview = movie.overview {
                    Text(overview)

                } else {
                    Text(verbatim: "")
                }
            }
            .lineLimit(1)
            .foregroundColor(.secondary)
            .font(.footnote)
        }
        .padding(.horizontal, 10)
    }
}

#if DEBUG
    struct MovieBannerTitle_Previews: PreviewProvider {
        static var previews: some View {
            NowPlayingBannerTitle(movie: PreviewData.previewMovie1)
        }
    }
#endif
