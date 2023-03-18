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
    @State var movies = [Movie]()

    var body: some View {
        VStack {
            switch deviceStatus {
            case .compact:
                NowPlayingTabView(movies: movies)
            default:
                NowPlayingScrollView(movies: movies)
            }
        }
        .task {
            // get now plaing movies
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
                    inWishlist: store.state.favorite.movies.contains(movie.id),
                    tapBanner: { store.send(.setDestination(to: [.nowPlaying, .movieDetail($0)])) },
                    updateWishlist: { store.send(.updateMovieWishlisth($0)) }
                )
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .getSizeByWidth(size: $size, aspectRatio: 9 / 16)
    }
}

struct NowPlayingScrollView: View {
    let movies: [Movie]
    @EnvironmentObject var store: Store

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(movies) { movie in
                    MovieNowPlayingBanner(
                        movie: movie,
                        backdropSize: .init(width: 540, height: 540 / 1.77),
                        inWishlist: store.state.favorite.movies.contains(movie.id),
                        tapBanner: { store.send(.setDestination(to: [.nowPlaying, .movieDetail($0)])) },
                        updateWishlist: { store.send(.updateMovieWishlisth($0)) }
                    )
                }
            }
        }
    }
}

struct MovieNowPlayingScrollView_Previews: PreviewProvider {
    static var previews: some View {
        MovieNowPlayingContainer()
            .environmentObject(Store())

        NavigationSplitView {
            Text("abc")
        } detail: {
            VStack {
                MovieNowPlayingContainer()
                Spacer()
            }
//            .toolbar(.hidden, for: .navigationBar)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .environmentObject(Store())
        .previewDevice(.init(rawValue: "iPad Pro (11-inch) (4th generation)"))
        .previewInterfaceOrientation(.landscapeLeft)
        .setDeviceStatus()
    }
}
