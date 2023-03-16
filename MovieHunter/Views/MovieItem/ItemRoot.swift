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

public struct MovieItem: View {
  let movieID: Int
  let imageURL: URL
  let movieName: String
  let rate: Double
  let duration: Int
  let releaseDate: Date
  let inWishlist: Bool
  let displayType: DisplayType
  var updateWishlist: (Int) -> Void

  @Environment(\.imagePipeline) var pipeline

  public init(
    movieID: Int,
    movieName: String,
    imageURL: URL,
    rate: Double,
    duration: Int,
    releaseDate: Date,
    inWishlist: Bool,
    displayType: DisplayType,
    updateWishlist: @escaping (Int) -> Void
  ) {
    self.movieID = movieID
    self.imageURL = imageURL
    self.movieName = movieName
    self.rate = rate
    self.duration = duration
    self.releaseDate = releaseDate
    self.inWishlist = inWishlist
    self.displayType = displayType
    self.updateWishlist = updateWishlist
  }

  var layout: AnyLayout {
    switch displayType {
    case .portrait:
      return AnyLayout(VStackLayout(alignment: .leading, spacing: 0))
    case .landscape:
      return AnyLayout(HStackLayout(alignment: .center, spacing: 0))
    }
  }

  var clipShape: AnyShape {
    if displayType == .landscape {
      return AnyShape(Rectangle())
    } else {
      return AnyShape(HalfRoundedRectangle(cornerRadius: 8))
    }
  }

  public var body: some View {
    layout {
      ItemPoster(imageURL: imageURL)
        .frame(width: displayType.imageSize.width,
               height: displayType.imageSize.height)
        .clipped()
        .overlay(alignment: .topLeading) {
          BookMarkCornerButton(
            movieID: movieID,
            inWishlist: inWishlist,
            updateWishlist: updateWishlist
          )
        }
      MovieShortInfo(
        movieName: movieName,
        rate: rate,
        duration: duration,
        releaseDate: releaseDate,
        displayType: displayType
      )
    }
    .overlay(alignment: .topTrailing) {
      if displayType == .landscape {
        Image(systemName: "ellipsis")
          .offset(x: -10, y: 16)
          .font(.title3)
          .bold()
          .foregroundColor(.secondary)
      }
    }
    .background(displayType == .landscape ? .clear : Color("movieItemPortraitBackgroundColor"))
    .compositingGroup()
    .clipShape(clipShape)
    .if(displayType != .landscape) { view in
      view
        .shadow(color: .secondary.opacity(0.3), radius: 3, x: 0, y: 2)
    }
  }
}

extension MovieItem {}

public enum DisplayType: Equatable {
  case portrait(Size)
  case landscape

  public enum Size: Equatable {
    case small
    case middle
    case large
  }

  var imageSize: CGSize {
    switch self {
    case .landscape:
      return .init(width: 86, height: 128)
    case .portrait(.small):
      return .init(width: 150, height: 223)
    case .portrait(.middle):
      return .init(width: 174, height: 260)
    case .portrait(.large):
      // TODO: - 设置成正确的 Large 尺寸
      return .init(width: 174, height: 260)
    }
  }
}

#if DEBUG
  struct MovieItem_Previews: PreviewProvider {
    static var previews: some View {
      VStack {
        MovieItem(
          movieID: 100,
          movieName: "The Lengend of 1900",
          imageURL: URL(string: "http://image.tmdb.org/t/p/w300/iOcbJ5pxokOPDRgieVDbsFMrCc6.jpg")!,
          rate: 8.5,
          duration: 175,
          releaseDate: .init(timeIntervalSince1970: 0),
          inWishlist: false,
          displayType: .landscape,
          updateWishlist: { id in print(id) }
        )
        .border(.gray)
        .padding(10)

        MovieItem(
          movieID: 100,
          movieName: "History of the World: Part II",
          imageURL: URL(string: "http://image.tmdb.org/t/p/w300/iOcbJ5pxokOPDRgieVDbsFMrCc6.jpg")!,
          rate: 8.5,
          duration: 175,
          releaseDate: .init(timeIntervalSince1970: 0),
          inWishlist: true,
          displayType: .portrait(.small),
          updateWishlist: { id in print(id) }
        )

        MovieItem(
          movieID: 100,
          movieName: "History of the World: Part II",
          imageURL: URL(string: "http://image.tmdb.org/t/p/w300/iOcbJ5pxokOPDRgieVDbsFMrCc6.jpg")!,
          rate: 8.5,
          duration: 175,
          releaseDate: .init(timeIntervalSince1970: 0),
          inWishlist: true,
          displayType: .portrait(.large),
          updateWishlist: { id in print(id) }
        )
      }
    }
  }
#endif
