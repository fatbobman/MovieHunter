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

    @Environment(\.goDetailFromHome) private var goDetailFromHome
    @Environment(\.goDetailFromCategory) private var goDetailFromCategory
    @Environment(\.colorScheme) private var colorScheme
    @State private var isPressed: Bool = false
    @StateObject private var configuration = AppConfiguration.share
    private var showBookMark: Bool {
        configuration.showBookMarkInPoster
    }

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
                guard let movie else { return }
                let destinationCategory: Category = category ?? (genreID != nil ? .genre(genreID!) : .popular)
                // from movie gallery
                if category == nil && genreID == nil {
                    goDetailFromCategory(movie)
                } else {
                    goDetailFromHome(destinationCategory, movie)
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
                    if displayType == .landscape {
                        Image(systemName: "chevron.forward")
                            .padding(.trailing, 16)
                            .foregroundColor(.secondary)
                    }
                }
                .background(displayType == .landscape ? .clear : Assets.Colors.rowBackground)
                .compositingGroup()
                .clipShape(clipShape)
                .contentShape(Rectangle())
                .if(displayType != .landscape) { view in
                    view
                        .shadow(color: .black.opacity(colorScheme == .dark ? 0.3 : 0.1), radius: 3, x: 0, y: 2)
                }
            }
            .buttonStyle(.pressStatus($isPressed))
            if showBookMark {
                BookMarkCornerButton(movieID: movie?.id)
            }
        }
        .scaleEffect(isPressed ? 0.95 : 1)
        .animation(.easeOut.speed(2), value: isPressed)
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
    struct MovieItemTest: View {
        @State var favorite: Bool = false
        var body: some View {
            MovieItem(
                movie: .previewMovie1,
                displayType: .portrait(.small)
            )
            .border(.gray)
            .padding(10)
            .environment(\.inWishlist) { _ in favorite }
            .environment(\.updateWishlist) { _ in favorite.toggle() }
        }
    }

    struct MovieItem_Previews: PreviewProvider {
        static var previews: some View {
            VStack {
                MovieItemTest()

                MovieItem(
                    movie: .previewMovie1,
                    displayType: .portrait(.small)
                )
                .environment(\.inWishlist) { _ in true }

                MovieItem(
                    movie: .previewMovie1,
                    displayType: .portrait(.large)
                )
            }
        }
    }
#endif
