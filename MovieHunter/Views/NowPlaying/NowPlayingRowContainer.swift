//
//  MovieNowPlayingContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI
import TMDb

struct NowPlayingRowContainer: View {
    @Environment(\.tmdb) private var tmdb
    @Environment(\.deviceStatus) private var deviceStatus
    @State private var movies = [Movie]()
    var body: some View {
        VStack(spacing: 0) {
            switch deviceStatus {
            case .compact:
                NowPlayingTabViewRow(movies: movies)
            default:
                NowPlayingScrollViewRow(movies: movies)
            }
            ViewMoreButton(
                title: Category.nowPlaying.localizedString,
                showSymbol: false,
                showViewMoreText: false,
                textSize: .small,
                destination: .nowPlaying
            )
        }
        .task {
            // get now playing movies by tmdb
            let movies = try? await tmdb.movies.nowPlaying(page: 1)
            self.movies = Array((movies?.results ?? []).prefix(10))
        }
    }
}

#if DEBUG
    struct MovieNowPlayingScrollView_Previews: PreviewProvider {
        static var previews: some View {
            NowPlayingRowContainer()
                .environment(\.colorScheme, .dark)
                .environment(\.backdropSize, .init(width: 400, height: 200))
                .environment(\.deviceStatus, .compact)
                .previewDevice(.init(rawValue: "iPhone 14 Pro"))

            NowPlayingRowContainer()
                .environmentObject(Store())
                .environment(\.deviceStatus, .regular)
                .previewDevice(.init(rawValue: "iPad Pro (11-inch) (4th generation)"))
                .previewInterfaceOrientation(.landscapeLeft)
                .frame(height: 450)
        }
    }
#endif
