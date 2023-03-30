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
    @Environment(\.goDetailFromHome) private var goDetailFromHome
    @Environment(\.deviceStatus) private var deviceStatus
    @Environment(\.colorScheme) private var colorScheme
    @Namespace private var nameSpace
    @StateObject private var configuration = AppConfiguration.share
    private var showBookMark: Bool {
        configuration.showBookMarkInPoster
    }

    var body: some View {
        Button {
            goDetailFromHome(.nowPlaying, movie)
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
            Group {
                if showBookMark {
                    BookMarkCornerButton(movieID: movie.id)
                        .matchedGeometryEffect(id: "posterTopLeading", in: nameSpace, anchor: .topLeading, isSource: false)
                }
            }
        )
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
            #if os(iOS)
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
                .previewDevice(.iPadName)
                .previewInterfaceOrientation(.landscapeLeft)
            #else
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        NowPlayingBanner(
                            movie: .previewMovie1,
                            backdropSize: .init(width: 540, height: 540 / 1.77)
                        )

                        NowPlayingBanner(
                            movie: .previewMovie2,
                            backdropSize: .init(width: 540, height: 540 / 1.77)
                        )
                    }
                }
                .frame(width: 800)
            #endif
        }
    }
#endif
