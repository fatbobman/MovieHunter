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
  let imageURL: URL
  @Environment(\.imagePipeline) var imagePipeline
  var body: some View {
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
  }
}

struct ItemPosterPreview: PreviewProvider {
  static var previews: some View {
    ItemPoster(imageURL: URL(string: "http://image.tmdb.org/t/p/w300/iOcbJ5pxokOPDRgieVDbsFMrCc6.jpg")!)
      .frame(
        width: DisplayType.portrait(.small).imageSize.width,
        height: DisplayType.portrait(.small).imageSize.height
      )
  }
}
