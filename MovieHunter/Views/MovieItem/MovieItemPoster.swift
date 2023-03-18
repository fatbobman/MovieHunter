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
    let movie: Movie
    let size: CGSize
    let inWishlist: Bool
    var updateWishlist: ((Int) -> Void)?
    @Environment(\.imagePipeline) var imagePipeline
    var body: some View {
        VStack {
            if let imageURL {
                LazyImage(url: imageURL) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
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
            if let updateWishlist {
                BookMarkCornerButton(
                    movieID: movie.id,
                    inWishlist: inWishlist,
                    updateWishlist: updateWishlist
                )
            }
        }
    }

    var imageURL: URL? {
        guard let path = movie.posterPath else { return nil }
        return moviePosterURLPrefix
            .appending(path: "/w300")
            .appending(path: path.absoluteString)
    }
}

#if DEBUG
    struct ItemPosterPreview: PreviewProvider {
        static var previews: some View {
            ItemPoster(movie: PreviewData.previewMovie, size: DisplayType.portrait(.small).imageSize, inWishlist: true, updateWishlist: { _ in print("update ") })

            ItemPoster(movie: PreviewData.previewMovie, size: DisplayType.portrait(.small).imageSize, inWishlist: false)

            ItemPoster(movie: PreviewData.previewMovie, size: DisplayType.portrait(.middle).imageSize, inWishlist: false)
        }
    }
#endif
