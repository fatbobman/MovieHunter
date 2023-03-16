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

struct ItemPoster: View {
    let imageURL: URL?
    @Environment(\.imagePipeline) var imagePipeline
    var body: some View {
        if let imageURL {
            LazyImage(url: imageURL) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    Color("imagePlaceHolderColor")
                }
            }
            .pipeline(imagePipeline)
        } else {
            Color.clear
        }
    }
}

struct ItemPosterPreview: PreviewProvider {
    static var previews: some View {
        ItemPoster(imageURL: PreviewData.portraitImageURL)
            .frame(
                width: DisplayType.portrait(.small).imageSize.width,
                height: DisplayType.portrait(.small).imageSize.height
            )

        ItemPoster(imageURL: nil)
            .frame(
                width: DisplayType.portrait(.small).imageSize.width,
                height: DisplayType.portrait(.small).imageSize.height
            )
            .border(.blue)
    }
}
