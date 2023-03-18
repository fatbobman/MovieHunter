//
//  ColorSchemeSetting.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation
import SwiftUI

enum ColorSchemeSetting: Int {
    case dark
    case light
    case system

    var colorSchmeme: ColorScheme? {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }

    var text: LocalizedStringKey {
        switch self {
        case .dark:
            return "Setting_DarkMode"
        case .light:
            return "Setting_LightMode"
        case .system:
            return "Setting_BySystemColorScheme"
        }
    }
}
