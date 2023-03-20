//
//  MovieNowPlayingScrollView.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI
import TMDb

struct MovieNowPlayingContainer: View {
    @Environment(\.tmdb) var tmdb
    @Environment(\.deviceStatus) var deviceStatus
    @EnvironmentObject var store: Store
    @State var movies = [Movie]()

    var body: some View {
        VStack(spacing: 0) {
            switch deviceStatus {
            case .compact:
                NowPlayingTabView(movies: movies)
            default:
                NowPlayingScrollView(movies: movies)
            }
            NowPlayingLabel(hideText: true, checkMore: {
                store.send(.setDestination(to: [.nowPlaying]))
            })
        }
        .task {
            // get now plaing movies by tmdb
            let movies = try? await tmdb.movies.nowPlaying(page: 1)
            self.movies = Array((movies?.results ?? []).prefix(10))
        }
    }
}

struct NowPlayingTabView: View {
    let movies: [Movie]
    @State var size: CGSize = .zero
    @EnvironmentObject var store: Store

    var body: some View {
        TabView {
            ForEach(movies) { movie in
                MovieNowPlayingBanner(
                    movie: movie,
                    backdropSize: size,
                    inWishlist: store.inWishlist(movie.id),
                    tapBanner: { store.send(.setDestination(to: [.nowPlaying, .movieDetail($0)])) },
                    updateWishlist: { store.send(.updateMovieWishlisth($0)) }
                )
            }
        }
        #if !os(macOS)
        .tabViewStyle(.page(indexDisplayMode: .never))
        #endif
        .getSizeByWidth(size: $size, aspectRatio: 9 / 16)
        .if(size != .zero) {
            $0.frame(width: size.width, height: size.height + 70)
        }
    }
}

struct NowPlayingScrollView: View {
    let movies: [Movie]
    @EnvironmentObject var store: Store

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(movies) { movie in
                    MovieNowPlayingBanner(
                        movie: movie,
                        backdropSize: .init(width: 540, height: 540 / 1.77),
                        inWishlist: store.state.favoriteMovieIDs.contains(movie.id),
                        tapBanner: { store.send(.setDestination(to: [.nowPlaying, .movieDetail($0)])) },
                        updateWishlist: { store.send(.updateMovieWishlisth($0)) }
                    )
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Assets.Colors.rowBackground)
    }
}

struct MovieNowPlayingScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MovieNowPlayingContainer()
            .environmentObject(Store())
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
