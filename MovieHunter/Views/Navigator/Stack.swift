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
        if showStack {
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
            .setBackdropSize()
        } else {
            Text("Movie Empty")
        }
    }
    
    // 测试时，屏蔽 Movie 视图，减少 TMDb 网络调用，防止被封
    let showStack: Bool = {
        #if DEBUG
        let arguments = ProcessInfo.processInfo.arguments
        var allow = true
        for index in 0 ..< arguments.count - 1 where arguments[index] == "-ShowMovie" {
            allow = arguments.count >= (index + 1) ? arguments[index + 1] == "1" : true
            break
        }
        return allow
        #else
        return true
        #endif
    }()
}

struct StackContainer_Previews: PreviewProvider {
    static var previews: some View {
        StackContainer()
            .environmentObject(Store.share)
    }
}
