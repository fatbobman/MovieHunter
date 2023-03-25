//
//  MovieNowPlayingTabViewWrapper.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/20.
//

import Foundation
import SwiftUI
import TMDb

struct NowPlayingTabViewRow: View {
    let movies: [Movie]
    @Environment(\.tabViewSize) private var tabViewSize

    var body: some View {
        TabView {
            ForEach(movies) { movie in
                NowPlayingBanner(
                    movie: movie,
                    backdropSize: tabViewSize
                )
            }
        }
        #if !os(macOS)
        .tabViewStyle(.page(indexDisplayMode: .never))
        #endif
        .frame(width: tabViewSize.width, height: tabViewSize.height)
    }
}

#if DEBUG
    struct NowPlayingTabViewRowPreview: PreviewProvider {
        static var previews: some View {
            NowPlayingTabViewRow(movies: [PreviewData.previewMovie1, PreviewData.previewMovie2])
                .frame(width: 400, height: 400)
        }
    }
#endif
