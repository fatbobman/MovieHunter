//
//  File.swift
//
//
//  Created by Yang Xu on 2023/3/14.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    func getSizeByWidth(size: Binding<CGSize>, aspectRatio: CGFloat = 1) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .task(id: proxy.size.width) {
                        size.wrappedValue = .init(width: proxy.size.width, height: proxy.size.width * aspectRatio)
                    }
            }
        )
    }
}
