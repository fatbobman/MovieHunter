//
//  SettingContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

struct SettingContainer: View {
    var body: some View {
        NavigationSplitView {
            SettingSidebar()
                .navigationDestination(for: SettingCategory.self) { category in
                    switch category {
                    case .appearance:
                        SettingAppearance()
                    case .preference:
                        EmptyView()
                    case .genre:
                        EmptyView()
                    case .networkAndStorage:
                        EmptyView()
                    case .about:
                        EmptyView()
                    }
                }
        } detail: {
            SettingHome()
        }
    }
}

struct SettingContainer_Previews: PreviewProvider {
    static var previews: some View {
        SettingContainer()
    }
}
