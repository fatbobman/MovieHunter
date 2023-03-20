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
            NowPlayingLabel(hideText: true, checkMore: {
//                store.send(.setDestination(to: [.nowPlaying]))
                goCategory(Destination.nowPlaying)
            })
        }
        .task {
            // get now plaing movies by tmdb
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

struct NowPlayingLabel: View {
    private let category = Category.nowPlaying
    let hideText: Bool
    let hideArrow: Bool
    let checkMore: () -> Void

    init(hideText: Bool = false, hideArrow: Bool = false, checkMore: @escaping () -> Void) {
        self.hideText = hideText
        self.hideArrow = hideArrow
        self.checkMore = checkMore
    }

    var body: some View {
        Assets.Colors.rowBackground
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .overlay(
                HStack(spacing: 10) {
                    Text(category.localizedString)
                        .font(.subheadline)
                    Spacer()
                    MoreButton(hideText: hideText, hideArrow: hideArrow, perform: checkMore)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            )
    }
}

struct MoreButton: View {
    let hideText: Bool
    let hideArrow: Bool
    let perform: () -> Void
    var body: some View {
        Button {
            perform()
        } label: {
            HStack(spacing: 3) {
                if !hideText {
                    Text("查看更多")
                }
                if !hideArrow {
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundColor(.blue)
            .font(.callout)
        }
        .buttonStyle(.plain)
    }
}
