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
    var body: some View {
        NavigationStack(path: $store.state.destinations) {
            Home()
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
    }
}

struct StackContainer_Previews: PreviewProvider {
    static var previews: some View {
        StackContainer()
            .environmentObject(Store.share)
    }
}
