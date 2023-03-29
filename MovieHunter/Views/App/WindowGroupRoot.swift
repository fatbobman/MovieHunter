//
//  WindowGroupRoot.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/27.
//

import Foundation
import SwiftUI

#if os(macOS)
    struct WindowGroupRoot: View {
        let category: Category?
        @StateObject var store = Store()
        var body: some View {
            ContentView()
                .environmentObject(store)
                .task {
                    if let category {
                        store.send(.setDestination(to: [category.destination]))
                    }
                }
        }
    }

    #if DEBUG
        struct WindowGroupRoot_Previews: PreviewProvider {
            static var previews: some View {
                WindowGroupRoot(category: .popular)
            }
        }
    #endif
#endif
