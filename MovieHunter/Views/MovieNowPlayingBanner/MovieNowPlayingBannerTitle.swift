//
//  MovieBannerTitle.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI
import TMDb

struct MovieNowPlayingBannerTitle: View {
    let movie: Movie
    var body: some View {
        VStack(alignment: .leading) {
            Text(movie.title)
                .font(.callout)
                .lineLimit(1)
            if let releaseDate = movie.releaseDate {
                Text(releaseDate, format: .dateTime.month().day())
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
    struct MovieBannerTitle_Previews: PreviewProvider {
        static var previews: some View {
            MovieNowPlayingBannerTitle(movie: PreviewData.previewMovie)
        }
    }
#endif
