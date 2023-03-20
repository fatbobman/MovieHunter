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

public struct MovieItem: View {
    let movie: Movie?
    let inWishlist: Bool
    let displayType: DisplayType
    let updateWishlist: (Int) -> Void
    let goDetail: (Movie) -> Void

    @Environment(\.colorScheme) var colorScheme

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
            ItemPoster(
                movie: movie,
                size: displayType.imageSize,
                inWishlist: inWishlist,
                updateWishlist: updateWishlist
            )
            MovieShortInfo(
                movie: movie,
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
        .background(displayType == .landscape ? .clear : Assets.Colors.rowBackground)
        .compositingGroup()
        .clipShape(clipShape)
        .if(displayType != .landscape) { view in
            view
                .shadow(color: .black.opacity(colorScheme == .dark ? 0.3 : 0.1), radius: 3, x: 0, y: 2)
        }
        .onTapGesture {
            if let movie {
                goDetail(movie)
            }
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
                    movie: PreviewData.previewMovie1,
                    inWishlist: false,
                    displayType: .landscape,
                    updateWishlist: { id in print(id) },
                    goDetail: { print($0) }
                )
                .border(.gray)
                .padding(10)

                MovieItem(
                    movie: PreviewData.previewMovie1,
                    inWishlist: true,
                    displayType: .portrait(.small),
                    updateWishlist: { id in print(id) },
                    goDetail: { print($0) }
                )

                MovieItem(
                    movie: PreviewData.previewMovie1,
                    inWishlist: true,
                    displayType: .portrait(.large),
                    updateWishlist: { id in print(id) },
                    goDetail: { print($0) }
                )
            }
        }
    }
#endif
