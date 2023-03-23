//
//  MovieBanner.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI
import TMDb

struct NowPlayingBanner: View {
    let movie: Movie
    let backdropSize: CGSize
    @Environment(\.goDetail) private var goDetail
    @Environment(\.deviceStatus) private var deviceStatus
    @Environment(\.colorScheme) private var colorScheme
    @Namespace private var nameSpace

    var body: some View {
        Button {
            goDetail(.nowPlaying, movie)
        } label: {
            VStack(alignment: .leading, spacing: -posterSize.height * 0.56) {
                NowPlayingBackdrop(movie: movie)
                    .frame(width: backdropSize.width, height: backdropSize.height)
                    .clipped()
                HStack(alignment: .lastTextBaseline) {
                    ItemPoster(
                        movie: movie,
                        size: posterSize,
                        showShadow: true,
                        enableScale: false
                    )
                    .matchedGeometryEffect(id: "posterTopLeading", in: nameSpace, properties: [.position], anchor: .topLeading, isSource: true)
                    NowPlayingBannerTitle(movie: movie)
                        .alignmentGuide(.lastTextBaseline) { $0[.lastTextBaseline] + 10 }
                }
                .padding(.leading, leadingPadding)
                .frame(width: backdropSize.width, alignment: .leading)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.flat)
        .overlay(
            BookMarkCornerButton(movieID: movie.id)
                .matchedGeometryEffect(id: "posterTopLeading", in: nameSpace, anchor: .topLeading, isSource: false)
        )
//        .onTapGesture {
//            goDetail(.nowPlaying, movie)
//        }
        .padding(.bottom, 15)
        .background(Assets.Colors.rowBackground)
    }

    var posterSize: CGSize {
        switch deviceStatus {
        case .compact:
            return .init(width: 100, height: 148)
        default:
            return .init(width: 109, height: 160)
        }
    }

    var leadingPadding: CGFloat {
        switch deviceStatus {
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
            NowPlayingBanner(
                movie: PreviewData.previewMovie1,
                backdropSize: .init(width: 393, height: 393 / 1.77)
            )
            .environment(\.colorScheme, .dark)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    NowPlayingBanner(
                        movie: PreviewData.previewMovie1,
                        backdropSize: .init(width: 540, height: 540 / 1.77)
                    )

                    NowPlayingBanner(
                        movie: PreviewData.previewMovie2,
                        backdropSize: .init(width: 540, height: 540 / 1.77)
                    )
                }
            }
            .previewDevice(.init(rawValue: "iPad Pro (11-inch) (4th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
        }
    }
#endif
