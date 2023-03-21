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
    let inWishlist: (Int) -> Bool
    let goDetail: (Movie) -> Void
    let updateWishlist: (Int) -> Void
    let goCategory: (Destination) -> Void

    @Environment(\.tmdb) private var tmdb
    @Environment(\.deviceStatus) private var deviceStatus
    @State private var movies = [Movie]()

    var body: some View {
        VStack(spacing: 0) {
            switch deviceStatus {
            case .compact:
                NowPlayingTabViewRow(
                    movies: movies,
                    inWishlist: inWishlist,
                    tapBanner: goDetail,
                    updateWishList: updateWishlist
                )

            default:
                NowPlayingScrollViewRow(
                    movies: movies,
                    inWishlist: inWishlist,
                    tapBanner: goDetail,
                    updateWishList: updateWishlist
                )
            }
            ViewMoreButton(
                title: Category.nowPlaying.localizedString,
                showSymbole: false,
                showViewMoreText: false,
                textSize: .small,
                perform: { goCategory(Destination.nowPlaying) }
            )
        }
        .task {
            // get now playing movies by tmdb
            let movies = try? await tmdb.movies.nowPlaying(page: 1)
            self.movies = Array((movies?.results ?? []).prefix(10))
        }
    }
}

struct MovieNowPlayingScrollView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingRowContainer(
            inWishlist: { _ in true },
            goDetail: { print($0) },
            updateWishlist: { print($0) },
            goCategory: { print($0) }
        )
        .environment(\.colorScheme, .dark)

//        NavigationSplitView {
//            Text("abc")
//        } detail: {
//            VStack {
//                MovieNowPlayingContainer()
//                Spacer()
//            }
//            .navigationTitle("")
//            #if !os(macOS)
//                .navigationBarTitleDisplayMode(.inline)
//            #endif
//        }
//        .environmentObject(Store())
//        .previewDevice(.init(rawValue: "iPad Pro (11-inch) (4th generation)"))
//        .previewInterfaceOrientation(.landscapeLeft)
//        .setDeviceStatus()
    }
}
