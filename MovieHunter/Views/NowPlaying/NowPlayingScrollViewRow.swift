//
//  NowPlayingScrollViewRow.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/20.
//

import Foundation
import SwiftUI
import TMDb

struct NowPlayingScrollViewRow: View {
    let movies: [Movie]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(movies) { movie in
                    NowPlayingBanner(
                        movie: movie,
                        backdropSize: .init(width: 540, height: 540 / 1.77)
                    )
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Assets.Colors.rowBackground)
    }
}

#if DEBUG
    struct NowPlayingScrollViewRowPreview: PreviewProvider {
        static var previews: some View {
            #if os(iOS)
                NowPlayingScrollViewRow(movies: [PreviewData.previewMovie1, PreviewData.previewMovie2])
                    .previewDevice(.iPadName)
                    .previewInterfaceOrientation(.landscapeLeft)

                NowPlayingScrollViewRow(movies: [PreviewData.previewMovie1, PreviewData.previewMovie2])
                    .previewDevice(.iPadName)
                    .previewInterfaceOrientation(.landscapeLeft)
                    .environment(\.colorScheme, .dark)
            #else
                NowPlayingScrollViewRow(movies: [PreviewData.previewMovie1, PreviewData.previewMovie2])
                    .frame(width: 800)
            #endif
        }
    }
#endif
