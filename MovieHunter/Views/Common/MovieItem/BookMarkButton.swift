//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/14.
//

import Foundation
import SwiftUI

public struct BookMarkCornerButton: View {
    private let movieID: Int?
    @Environment(\.inWishlist) private var inWishlist
    @Environment(\.updateWishlist) private var updateWishlist
    @State private var animation: Animation?

    private var isFavorite: Bool {
        guard let movieID else { return false }
        return inWishlist(movieID)
    }

    public init(movieID: Int?) {
        self.movieID = movieID
    }

    public var body: some View {
        Button {
            if let movieID {
                updateWishlist(movieID)
            }
        } label: {
            Color.clear
                .frame(width: 32, height: 40)
                .overlay(
                    BookMarkShape()
                        .fill(.black)
                        .overlay(
                            BookMarkShape()
                                .stroke(isFavorite ? .clear : .white.opacity(0.2), lineWidth: 0.5)
                        )
                        .overlay(alignment: .top) {
                            Image(systemName: isFavorite ? "checkmark" : "plus")
                                .foregroundColor(isFavorite ? .black : .white)
                                .font(.callout)
                                .bold()
                                .alignmentGuide(.top) { _ in -8 }
                        }
                )
                .overlay(
                    VStack {
                        if isFavorite {
                            BookMarkShape()
                                .fill(Assets.Colors.favorite)
                                .overlay(alignment: .top) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.black)
                                        .font(.callout)
                                        .bold()
                                        .alignmentGuide(.top) { _ in -8 }
                                }
                                .transition(.scale(scale: 1.7).combined(with: .opacity))
                        }
                    }
                    .animation(animation, value: isFavorite)
                )
                .contentShape(Rectangle())
        }
        .buttonStyle(.flat)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { animation = .spring() }
        }
        .onDisappear { animation = nil }
    }
}

struct BookMarkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let y = CGFloat(33) / CGFloat(40) * (rect.maxY - rect.minY)
        path.move(to: .zero)
        path.addLine(to: .init(x: rect.maxX, y: rect.minY))
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        path.addLine(to: .init(x: rect.midX, y: y))
        path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: .init(x: rect.minX, y: rect.minY))
        return path
    }
}

#if DEBUG
    struct BookMarkCornerButtonPreviewWrapper: View {
        @State var inWishlist = false
        var body: some View {
            HStack {
                BookMarkCornerButton(movieID: 100)
            }
            .padding()
            .background(.black)
            .environment(\.updateWishlist) { _ in inWishlist.toggle() }
            .environment(\.inWishlist) { _ in inWishlist }
        }
    }

    struct BookMarCornerButtonPreview: PreviewProvider {
        static var previews: some View {
            BookMarkCornerButtonPreviewWrapper()
        }
    }
#endif
