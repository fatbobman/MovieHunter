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
    var body: some View {
        NavigationSplitView {
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
                    .toolbar(.hidden, for: .windowToolbar)
                    #endif
                }
        } detail: {
            SettingHome()
            #if os(macOS)
                .toolbar(.hidden, for: .windowToolbar)
            #endif
        }
        #if os(macOS)
        .frame(width: 550, height: 400)
        .preferredColorScheme(configuration.colorScheme.colorScheme)
        .environment(\.locale, configuration.appLanguage.locale)
        #endif
    }
}

struct SettingContainer_Previews: PreviewProvider {
    static var previews: some View {
        SettingContainer()
    }
}
