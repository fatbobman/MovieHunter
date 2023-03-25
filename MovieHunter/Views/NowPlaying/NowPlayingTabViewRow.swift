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
    @Environment(\.backdropSize) private var size
    var body: some View {
        // TODO: 自动滚屏控件
        TabView {
            ForEach(movies) { movie in
                NowPlayingBanner(
                    movie: movie,
                    backdropSize: size
                )
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: size.width, height: size.height + 70)
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
