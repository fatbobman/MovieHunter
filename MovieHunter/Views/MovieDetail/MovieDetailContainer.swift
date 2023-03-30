//
//  MovieDetailContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI
import TMDb

struct MovieDetailContainer: View {
    @State private var movie: Movie?
    @Environment(\.deviceStatus) var deviceStatus
    @EnvironmentObject var store: Store

    private var compact: Bool {
        deviceStatus == .compact
    }

    private var regular: Bool {
        deviceStatus == .regular
    }

    private let movieID: Int
    init(movie: Movie) {
        movieID = movie.id
    }

    @Environment(\.tmdb) private var tmdb
    var body: some View {
        VStack(alignment: .leading) {
            if let movie {
                HStack(spacing: 0) {
                    MovieDetail(movie: movie)
                        .frame(idealWidth: 500, maxWidth: 800)
                        .layoutPriority(1)

                    if !compact {
                        VStack(alignment: .leading) {
                            DetailGallery(movie: movie)
                                .padding(.leading, 10)
                        }
                        .background(
                            Rectangle()
                                .fill(.secondary.opacity(0.1).shadow(.inner(radius: 2, x: 2, y: 0)))
                        )
                        .frame(minWidth: 150)
                    }
                }
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .if(regular) {
            $0
                .navigationTitle(movie?.title ?? "")
            #if !os(macOS)
                .toolbarBackground(.visible, for: .navigationBar) // 处理 iPad 下 toolbar 显示异常
                .toolbarBackground(.visible, for: .tabBar)
            #endif
        }
        #if os(macOS)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button {
                    store.send(.setDestination(to: []))
                } label: {
                    Image(systemName: "house.fill")
                }
            }
        }
        #endif
            .task {
                if let movie = try? await tmdb.movies.details(forMovie: movieID) {
                    self.movie = movie
                }
            }
    }
}

#if DEBUG
    struct MovieDetailContainer_Previews: PreviewProvider {
        static var previews: some View {
            #if os(iOS)
            MovieDetailContainer(movie: PreviewData.previewMovie1)
                .environment(\.deviceStatus, .compact)
                .previewDevice(.init(rawValue: "iPhone 14 Pro"))

            MovieDetailContainer(movie: PreviewData.previewMovie1)
                .environment(\.deviceStatus, .regular)
                .previewDevice(.init(rawValue: "iPad Pro 11'"))

            MovieDetailContainer(movie: PreviewData.previewMovie1)
                .environment(\.deviceStatus, .regular)
                .previewDevice(.init(rawValue: "iPad Pro 11'"))
                .previewInterfaceOrientation(.landscapeLeft)
            #endif

            #if os(macOS)
                MovieDetailContainer(movie: PreviewData.previewMovie1)
                    .environment(\.deviceStatus, .macOS)
                    .frame(width: 1200, height: 800)
            #endif
        }
    }
#endif
