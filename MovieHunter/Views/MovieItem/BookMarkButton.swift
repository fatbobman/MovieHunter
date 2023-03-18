//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/14.
//

import Foundation
import SwiftUI

public struct BookMarkCornerButton: View {
    let movieID: Int
    let inWishlist: Bool
    var updateWishlist: (Int) -> Void

    public init(
        movieID: Int,
        inWishlist: Bool,
        updateWishlist: @escaping (Int) -> Void
    ) {
        self.movieID = movieID
        self.inWishlist = inWishlist
        self.updateWishlist = updateWishlist
    }

    public var body: some View {
        Color.clear
            .frame(width: 32, height: 40)
            .overlay(
                BookMarkShap()
                    .fill(.black)
                    .overlay(
                        BookMarkShap()
                            .stroke(inWishlist ? .clear : .white.opacity(0.2), lineWidth: 0.5)
                    )
                    .overlay(alignment: .top) {
                        Image(systemName: inWishlist ? "checkmark" : "plus")
                            .foregroundColor(inWishlist ? .black : .white)
                            .font(.callout)
                            .bold()
                            .alignmentGuide(.top) { _ in -8 }
                    }
            )
            .overlay(
                VStack {
                    if inWishlist {
                        BookMarkShap()
                            .fill(Color("starYellow"))
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
                .animation(.spring(), value: inWishlist)
            )
            .contentShape(Rectangle())
            .onTapGesture {
                updateWishlist(movieID)
            }
    }
}

struct BookMarkShap: Shape {
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
    private struct PreviewWrapper: View {
        @State var inWishlist = false
        var body: some View {
            HStack {
                BookMarkCornerButton(
                    movieID: 100,
                    inWishlist: inWishlist,
                    updateWishlist: { _ in
                        inWishlist.toggle()
                    }
                )
            }
            .padding()
            .background(.black)
        }
    }

    struct BookMarConerButtonPreview: PreviewProvider {
        static var previews: some View {
            PreviewWrapper()
        }
    }
#endif
