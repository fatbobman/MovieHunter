//
//  NavigationStack.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct StackContainer: View {
    @EnvironmentObject var store: Store
    @State private var size: CGSize = .zero
    var body: some View {
        NavigationStack(path: $store.state.destinations) {
            Home()
                .environment(\.tabViewSize, size)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .favoritePerson:
                        EmptyView()
                    case .movieDetail:
                        // movie Detail
                        EmptyView()
                    case .personDetail:
                        EmptyView()
                    default:
                        if let category = destination.category {
                            MovieGalleryDataSource(category: category)
                        }
                    }
                }
        }
        .getSizeByWidth(size: $size, aspectRatio: 9 / 16)
    }
}

struct StackContainer_Previews: PreviewProvider {
    static var previews: some View {
        StackContainer()
            .environmentObject(Store.share)
    }
}
