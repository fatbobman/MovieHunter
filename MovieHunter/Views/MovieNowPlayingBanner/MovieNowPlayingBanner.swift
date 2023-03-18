//
//  MovieBanner.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI
import TMDb

struct MovieNowPlayingBanner: View {
    let movie: Movie
    let width: CGFloat
    let inWishlist: Bool
    var tapBanner: (Int) -> Void
    var updateWishlist: (Int) -> Void
    @Environment(\.deviceStatus) var devieStaus
    var body: some View {
        VStack(alignment: .leading, spacing: -posterSize.height * 0.56) {
            MovieNowPlayingBackdrop(movie: movie)
            HStack(alignment: .lastTextBaseline) {
                ItemPoster(movie: movie, size: posterSize, inWishlist: inWishlist, updateWishlist: updateWishlist)
                MovieNowPlayingBannerTitle(movie: movie)
                    .alignmentGuide(.lastTextBaseline) { $0[.lastTextBaseline] + 10 }
            }
            .padding(.leading, leadingPadding)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            tapBanner(movie.id)
        }
        .padding(.bottom, 15)
        .background(Assets.Colors.movieItemPortraitBackground)
    }

    var posterSize: CGSize {
        switch devieStaus {
        case .compact:
            return .init(width: 100, height: 148)
        default:
            return .init(width: 109, height: 160)
        }
    }

    var leadingPadding: CGFloat {
        switch devieStaus {
        case .compact:
            return 16
        default:
            return 25
        }
    }

    var posterPath: URL? {
        guard let path = movie.posterPath else { return nil }
        return moviePosterURLPrefix
            .appending(path: "/w300")
            .appending(path: path.absoluteString)
    }
}

#if DEBUG
    struct MovieBanner_Previews: PreviewProvider {
        static var previews: some View {
            MovieNowPlayingBanner(
                movie: PreviewData.previewMovie,
                width: 400,
                inWishlist: true,
                tapBanner: { id in print("Tapped \(id)") }, updateWishlist: { _ in print("update") }
            )
            .frame(width: 393, height: 393 / 1.77)
            .environment(\.colorScheme, .dark)
        }
    }
#endif
