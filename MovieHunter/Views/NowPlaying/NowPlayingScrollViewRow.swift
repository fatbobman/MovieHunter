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
        #if !os(tvOS)
        .scrollContentBackground(.hidden)
        #endif
        .background(Assets.Colors.rowBackground)
    }
}

#if DEBUG
    struct NowPlayingScrollViewRowPreview: PreviewProvider {
        static var previews: some View {
            NowPlayingScrollViewRow(movies: [PreviewData.previewMovie1, PreviewData.previewMovie2])
                .previewDevice(.init(rawValue: "iPad Pro (11-inch) (4th generation)"))
                .previewInterfaceOrientation(.landscapeLeft)

            NowPlayingScrollViewRow(movies: [PreviewData.previewMovie1, PreviewData.previewMovie2])
                .previewDevice(.init(rawValue: "iPad Pro (11-inch) (4th generation)"))
                .previewInterfaceOrientation(.landscapeLeft)
                .environment(\.colorScheme, .dark)
        }
    }
#endif
