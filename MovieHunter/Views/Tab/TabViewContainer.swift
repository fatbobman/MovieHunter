//
//  TabViewContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct TabViewContainer: View {
    @EnvironmentObject private var store: Store

    var selection: Binding<TabDestination> {
        store.binding(for: \.tabDestination, toAction: {
            .TabItemButtonTapped($0)
        })
    }

    var body: some View {
        TabView(selection: selection) {
            StackContainer()
                .tag(TabDestination.movie)
                .tabItem {
                    Label("Tab_Home", systemImage: "house.fill")
                }
            SettingContainer()
                .tag(TabDestination.setting)
                .tabItem {
                    Label("Tab_Setting", systemImage: "gear")
                }
        }
    }
}

struct TabViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        #if os(iOS)
            TabViewContainer()
                .environmentObject(Store.share)
                .previewDevice(.init(rawValue: "iPhone 14 Pro"))

            TabViewContainer()
                .environmentObject(Store.share)
                .environment(\.deviceStatus, .regular)
                .previewDevice(.init(rawValue: "iPad Pro 11'"))
        #endif
    }
}
