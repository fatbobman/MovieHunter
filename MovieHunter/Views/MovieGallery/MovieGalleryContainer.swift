//
//  MovieGalleryContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/24.
//

import Foundation
import SwiftUI
import TMDb

struct MovieGalleryContainer: View {
    let movies: AnyRandomAccessCollection<Movie>
    @Environment(\.deviceStatus) private var deviceStatus

    var body: some View {
        VStack {
            switch deviceStatus {
            case .macOS, .regular:
                GalleryLazyVGrid(movies: movies)
            case .compact:
                GalleryLazyVStack(movies: movies)
            }
        }
        .animation(.default, value: movies.count)
    }
}

struct GalleryLazyVGrid: View {
    let movies: AnyRandomAccessCollection<Movie>
    @Environment(\.isLoading) private var isLoading
    private let minWidth: CGFloat = DisplayType.portrait(.middle).imageSize.width + 10
    var body: some View {
        ScrollView(.vertical) {
            let columns: [GridItem] = [.init(.adaptive(minimum: minWidth))]
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(movies) { movie in
                    MovieItem(movie: movie, displayType: .portrait(.middle))
                }
            }
            .padding(.vertical, 20)
            if isLoading {
                ProgressView()
                    .padding(10)
            }
        }
    }
}

struct GalleryLazyVStack: View {
    let movies: AnyRandomAccessCollection<Movie>
    @Environment(\.isLoading) private var isLoading
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(movies) { movie in
                    VStack(spacing: 0) {
                        Divider().frame(height: 0.3)
                        MovieItem(movie: movie, displayType: .landscape)
                            .padding(.vertical, 10)
                        if movie.id == movies.last?.id {
                            Divider().frame(height: 0.3)
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
            if isLoading {
                ProgressView()
                    .padding(10)
            }
        }
    }
}

struct MovieGalleryContainer_Previews: PreviewProvider {
    static var previews: some View {
        MovieGalleryContainer(
            movies: AnyRandomAccessCollection(
                [
                    .previewMovie1,
                    .previewMovie2,
                ]
            )
        )
        .frame(width: 400)
        .environment(\.deviceStatus, .compact)

        MovieGalleryContainer(
            movies: AnyRandomAccessCollection(
                [
                    .previewMovie1,
                    .previewMovie2,
                ]
            )
        )
        .environment(\.deviceStatus, .regular)
        .frame(width: 400)
    }
}
