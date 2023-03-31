//
//  SettingContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct SettingContainer: View {
    @StateObject var configuration = AppConfiguration.share
    @State private var visibility: NavigationSplitViewVisibility = .doubleColumn
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            SettingSidebar()
                .navigationDestination(for: SettingCategory.self) { category in
                    Group {
                        switch category {
                        case .appearance:
                            SettingAppearance()
                        case .genres:
                            SettingGenres()
                        case .storage:
                            SettingStorage()
                        case .about:
                            About()
                        case .library:
                            SettingLibrary()
                        }
                    }
                    #if os(macOS)
                    .frame(minWidth: 400)
                    .toolbar(.hidden, for: .windowToolbar)
                    #endif
                }
        } detail: {
            SettingHome()
            #if os(macOS)
                .frame(minWidth: 400)
                .navigationTitle("Setting_Title")
                .toolbar(.hidden, for: .windowToolbar)
            #else
                .navigationBarTitleDisplayMode(.inline)
            #endif
        }
        #if os(macOS)
        .frame(width: 550, height: 400)
        .preferredColorScheme(configuration.colorScheme.colorScheme)
        .environment(\.locale, configuration.appLanguage.locale)
        .task {
            for await _ in Timer.publish(every: 0.3, on: .main, in: .common).autoconnect().values {
                if visibility != .doubleColumn {
                    visibility = .doubleColumn
                }
            }
        }
        #endif
    }
}

struct SettingContainer_Previews: PreviewProvider {
    static var previews: some View {
        SettingContainer()
    }
}
