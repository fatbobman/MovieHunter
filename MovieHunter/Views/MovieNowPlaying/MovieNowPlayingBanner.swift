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
    let backdropSize: CGSize
    let inWishlist: Bool
    var tapBanner: (Movie) -> Void
    var updateWishlist: (Int) -> Void
    @Environment(\.deviceStatus) var devieStaus
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(alignment: .leading, spacing: -posterSize.height * 0.56) {
            MovieNowPlayingBackdrop(movie: movie)
                .frame(width: backdropSize.width, height: backdropSize.height)
            HStack(alignment: .lastTextBaseline) {
                ItemPoster(
                    movie: movie,
                    size: posterSize,
                    showShadow: true,
                    inWishlist: inWishlist,
                    updateWishlist: updateWishlist
                )
                MovieNowPlayingBannerTitle(movie: movie)
                    .alignmentGuide(.lastTextBaseline) { $0[.lastTextBaseline] + 10 }
            }
            .padding(.leading, leadingPadding)
            .frame(width: backdropSize.width, alignment: .leading)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            tapBanner(movie)
        }
        .padding(.bottom, 15)
        .background(Assets.Colors.rowBackground)
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
                backdropSize: .init(width: 393, height: 393 / 1.77),
                inWishlist: true,
                tapBanner: { id in print("Tapped \(id)") }, updateWishlist: { _ in print("update") }
            )
            .environment(\.colorScheme, .dark)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    MovieNowPlayingBanner(
                        movie: PreviewData.previewMovie,
                        backdropSize: .init(width: 540, height: 540 / 1.77),
                        inWishlist: true,
                        tapBanner: { id in print("Tapped \(id)") }, updateWishlist: { _ in print("update") }
                    )

                    MovieNowPlayingBanner(
                        movie: PreviewData.previewMovie,
                        backdropSize: .init(width: 540, height: 540 / 1.77),
                        inWishlist: true,
                        tapBanner: { id in print("Tapped \(id)") }, updateWishlist: { _ in print("update") }
                    )
                }
            }
            .previewDevice(.init(rawValue: "iPad Pro (11-inch) (4th generation)"))
//            .previewInterfaceOrientation(.landscapeLeft)
        }
    }
#endif
