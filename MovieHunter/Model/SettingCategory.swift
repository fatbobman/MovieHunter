//
//  SettingCategory.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

enum SettingCategory: Int, CaseIterable, Hashable {
    case appearance
    case genre
    case networkAndStorage
    case about

    var localizedString: LocalizedStringKey {
        switch self {
        case .appearance:
            return "SettingCategory_Appearance"
        case .genre:
            return "SettingCategory_Genre"
        case .networkAndStorage:
            return "SettingCategory_NetworkAndStorage"
        case .about:
            return "SettingCategory_About"
        }
    }
}
