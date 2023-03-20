//
//  WishlistEmpty.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/20.
//

import Foundation
import SwiftUI

struct WishlistEmpty: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Assets.Colors.mainBackground)
            .padding(.bottom,20)
            .padding(.horizontal, 16)
            .overlay(
                VStack {
                    bookMark
                        .padding(.top, 20)
                    Text("Wishlist_Is_Empty_Title")
                        .font(.subheadline)
                        .padding(.vertical, 20)
                    Text("Wishlist_Is_Empty_Description_1")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Wishlist_Is_Empty_Description_2")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 35)
                        .padding(.bottom, 30)
                }
            )
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Assets.Colors.rowBackground)
    }

    var bookMark: some View {
        Color.clear
            .frame(width: 32, height: 40)
            .overlay(
                BookMarkShap()
                    .fill(.black)
                    .overlay(
                        BookMarkShap()
                            .stroke(colorScheme != .dark ? .clear : .white.opacity(0.2), lineWidth: 0.5)
                    )
                    .overlay(alignment: .top) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.callout)
                            .bold()
                            .alignmentGuide(.top) { _ in -8 }
                    }
            )
    }
}

struct WishlistEmpty_Previews: PreviewProvider {
    static var previews: some View {
        WishlistEmpty()
    }
}
