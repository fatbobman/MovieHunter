//
//  ColorSchemeSetting.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI

enum ColorSchemeSetting: Int, CaseIterable, Identifiable {
    case dark
    case light
    case system

    var colorScheme: ColorScheme? {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }

    var localizedString: LocalizedStringKey {
        switch self {
        case .dark:
            return "Setting_DarkMode"
        case .light:
            return "Setting_LightMode"
        case .system:
            return "Setting_BySystem"
        }
    }

    var id: Self {
        self
    }
}
