//
//  SettingCategory.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

enum SettingCategory {
    case appearance
    case preference
    case genre
    case networkAndStorage

    var localizedString: LocalizedStringKey {
        switch self {
        case .appearance:
            return "SettingCategory_Appearance"
        case .preference:
            return "SettingCategory_Preference"
        case .genre:
            return "SettingCategory_Genre"
        case .networkAndStorage:
            return "SettingCategory_NetworkAndStorage"
        }
    }
}
