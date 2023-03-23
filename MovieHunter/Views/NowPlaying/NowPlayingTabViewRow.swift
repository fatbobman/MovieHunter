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
    @State private var size: CGSize = .zero

    var body: some View {
        TabView {
            ForEach(movies) { movie in
                NowPlayingBanner(
                    movie: movie,
                    backdropSize: size
                )
            }
        }
        #if !os(macOS)
        .tabViewStyle(.page(indexDisplayMode: .never))
        #endif
        .getSizeByWidth(size: $size, aspectRatio: 9 / 16)
        .if(size != .zero) {
            // 在 ScrollView + TabView + Geometry 的组合下，需要显式设定尺寸
            $0.frame(width: size.width, height: size.height + 70)
        }
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
