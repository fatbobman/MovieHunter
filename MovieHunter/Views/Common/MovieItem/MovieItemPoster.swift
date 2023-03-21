//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/13.
//

import Foundation
import Nuke
import NukeUI
import SwiftUI
import TMDb

struct ItemPoster: View {
    let movie: Movie?
    let size: CGSize
    let showShadow: Bool
    let enableScale: Bool
    let inWishlist: Bool
    var updateWishlist: ((Int) -> Void)?
    @Environment(\.imagePipeline) var imagePipeline

    @State private var scale: CGFloat = 1

    init(
        movie: Movie?,
        size: CGSize,
        showShadow: Bool = false,
        enableScale: Bool = true,
        inWishlist: Bool,
        updateWishlist: ((Int) -> Void)? = nil
    ) {
        self.movie = movie
        self.size = size
        self.showShadow = showShadow
        self.enableScale = enableScale
        self.inWishlist = inWishlist
        self.updateWishlist = updateWishlist
    }

    var body: some View {
        VStack {
            if let imageURL {
                LazyImage(url: imageURL) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .scaleEffect(scale)
                            .animation(.default, value: scale)
                        #if os(macOS)
                            .onContinuousHover(coordinateSpace: .local) { phase in
                                switch phase {
                                case .active:
                                    if enableScale {
                                        scale = 1.2
                                    }
                                case .ended:
                                    scale = 1
                                }
                            }
                        #endif
                    } else {
                        Assets.Colors.imagePlaceHolder
                    }
                }
                .pipeline(imagePipeline)
            } else {
                Assets.Colors.imagePlaceHolder
            }
        }
        .frame(width: size.width, height: size.height)
        .clipped()
        .overlay(alignment: .topLeading) {
            if let movie, let updateWishlist {
                BookMarkCornerButton(
                    movieID: movie.id,
                    inWishlist: inWishlist,
                    updateWishlist: updateWishlist
                )
            }
        }
        .compositingGroup()
        .if(showShadow) {
            $0.shadow(radius: 3)
        }
    }

    var imageURL: URL? {
        guard let movie, let path = movie.posterPath else { return nil }
        return moviePosterURLPrefix
            .appending(path: "/w300")
            .appending(path: path.absoluteString)
    }
}

#if DEBUG
    struct ItemPosterPreview: PreviewProvider {
        static var previews: some View {
            ItemPoster(movie: PreviewData.previewMovie1, size: DisplayType.portrait(.small).imageSize, inWishlist: true, updateWishlist: { _ in print("update ") })

            ItemPoster(movie: PreviewData.previewMovie1, size: DisplayType.portrait(.small).imageSize, inWishlist: false)

            ItemPoster(movie: PreviewData.previewMovie1, size: DisplayType.portrait(.middle).imageSize, inWishlist: false)
        }
    }
#endif