//
//  ViewMore.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/20.
//

import Foundation
import SwiftUI
import TMDb

struct ViewMoreButton: View {
    private let title: LocalizedStringKey
    private let showSymbol: Bool
    private let showViewMoreText: Bool
    private let showArrow: Bool
    private let textSize: TextSize
    @Environment(\.goCategory) private var goCategory

    init(
        title: LocalizedStringKey,
        showSymbol: Bool = true,
        showViewMoreText: Bool = true,
        showArrow: Bool = true,
        textSize: TextSize = .middle
    ) {
        self.title = title
        self.showSymbol = showSymbol
        self.showViewMoreText = showViewMoreText
        self.showArrow = showArrow
        self.textSize = textSize
    }

    var body: some View {
        Button {
            goCategory(.favoritePerson)
        } label: {
            Assets.Colors.rowBackground
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .overlay(
                    HStack(spacing: 10) {
                        if showSymbol {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(Assets.Colors.favorite)
                                .frame(width: 4)
                                .padding(.vertical, 18)
                        }
                        Text(title)
                            .font(textSize.CategorySize)
                            .foregroundColor(.primary)
                        Spacer()
                        HStack(spacing: 3) {
                            HStack(spacing: 3) {
                                if showViewMoreText {
                                    Text("ViewMore")
                                }
                                if showArrow {
                                    Image(systemName: "chevron.right")
                                }
                            }
                            .foregroundColor(.blue)
                            .font(textSize.arrowSize)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                )
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    enum TextSize {
        case small
        case middle
        case large

        var CategorySize: Font {
            switch self {
            case .small:
                return .subheadline
            case .middle:
                return .headline
            case .large:
                return .title3
            }
        }

        var arrowSize: Font {
            switch self {
            case .small:
                return .callout
            case .middle:
                return .callout
            case .large:
                return .callout
            }
        }
    }
}

struct NowPlayingLabel: View {
    private let category = Category.nowPlaying
    let hideText: Bool
    let hideArrow: Bool
    let checkMore: () -> Void

    init(hideText: Bool = false, hideArrow: Bool = false, checkMore: @escaping () -> Void) {
        self.hideText = hideText
        self.hideArrow = hideArrow
        self.checkMore = checkMore
    }

    var body: some View {
        Assets.Colors.rowBackground
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .overlay(
                HStack(spacing: 10) {
                    Text(category.localizedString)
                        .font(.subheadline)
                    Spacer()
                    MoreButton(hideText: hideText, hideArrow: hideArrow, perform: checkMore)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
            )
    }
}

struct MoreButton: View {
    let hideText: Bool
    let hideArrow: Bool
    let perform: () -> Void
    var body: some View {
        Button {
            perform()
        } label: {
            HStack(spacing: 3) {
                if !hideText {
                    Text("查看更多")
                }
                if !hideArrow {
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundColor(.blue)
            .font(.callout)
        }
        .buttonStyle(.plain)
    }
}

#if DEBUG
    struct ViewMoreButton_Previews: PreviewProvider {
        static var previews: some View {
            VStack {
                ViewMoreButton(
                    title: Category.nowPlaying.localizedString,
                    showSymbol: false,
                    showViewMoreText: false,
                    textSize: .small
                )

                ViewMoreButton(title: Category.movieWishlist.localizedString)
            }
        }
    }
#endif
