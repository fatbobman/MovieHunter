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
    private let movie: Movie?
    private let category: Category?
    private let genreID: Genre.ID?
    private let displayType: DisplayType

    @Environment(\.goDetail) private var goDetail
    @Environment(\.colorScheme) private var colorScheme

    init(
        movie: Movie?,
        category: Category? = nil,
        genreID: Genre.ID? = nil,
        displayType: DisplayType
    ) {
        self.movie = movie
        self.category = category
        self.genreID = genreID
        self.displayType = displayType
    }

    private var layout: AnyLayout {
        switch displayType {
        case .portrait:
            return AnyLayout(VStackLayout(alignment: .leading, spacing: 0))
        case .landscape:
            return AnyLayout(HStackLayout(alignment: .center, spacing: 0))
        }
    }

    private var clipShape: AnyShape {
        if displayType == .landscape {
            return AnyShape(Rectangle())
        } else {
            return AnyShape(HalfRoundedRectangle(cornerRadius: 8))
        }
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            Button {
                if let movie {
                    var destinationCategory: Category = .popular
                    if let category {
                        destinationCategory = category
                    }
                    if let genreID {
                        destinationCategory = .genre(genreID)
                    }
                    goDetail(destinationCategory, movie)
                }
            } label: {
                layout {
                    ItemPoster(
                        movie: movie,
                        size: displayType.imageSize
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
            }
            .buttonStyle(.flat)

            BookMarkCornerButton(movieID: movie?.id)
        }
    }
}

public enum DisplayType: Equatable {
    case portrait(Size)
    case landscape

    public enum Size: Equatable {
        case tint
        case small
        case middle
        case large
    }

    var imageSize: CGSize {
        switch self {
        case .landscape:
            return .init(width: 86, height: 128)
        case .portrait(.tint):
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
                    displayType: .landscape
                )
                .border(.gray)
                .padding(10)
                .environment(\.inWishlist) { _ in false }

                MovieItem(
                    movie: PreviewData.previewMovie1,
                    displayType: .portrait(.small)
                )
                .environment(\.inWishlist) { _ in true }

                MovieItem(
                    movie: PreviewData.previewMovie1,
                    displayType: .portrait(.large)
                )
            }
        }
    }
#endif
