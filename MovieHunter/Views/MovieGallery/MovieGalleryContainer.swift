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
        switch deviceStatus {
        case .macOS, .regular:
            GalleryLazyVGrid(movies: movies)
        case .compact:
            GalleryLazyVStack(movies: movies)
        }
    }
}

struct GalleryLazyVGrid: View {
    let movies: AnyRandomAccessCollection<Movie>
    private let minWidth: CGFloat = DisplayType.portrait(.middle).imageSize.width + 10
    var body: some View {
        ScrollView(.vertical) {
            let columns: [GridItem] = [.init(.adaptive(minimum: minWidth))]
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(movies) { movie in
                    MovieItem(movie: movie, displayType: .portrait(.middle))
                }
            }
        }
    }
}

struct GalleryLazyVStack: View {
    let movies: AnyRandomAccessCollection<Movie>
    var body: some View {
        ScrollView {
            LazyVStack(spacing:0) {
                ForEach(movies) { movie in
                    VStack(spacing:0) {
                        Divider().frame(height:0.3)
                        MovieItem(movie: movie, displayType: .landscape)
                            .padding(.vertical,10)
                        if movie.id == movies.last?.id {
                            Divider().frame(height:0.3)
                        }
                    }
                    .padding(.horizontal,10)
                }
            }
        }
    }
}

// struct MovieGalleryContainer_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieGalleryContainer()
//    }
// }
