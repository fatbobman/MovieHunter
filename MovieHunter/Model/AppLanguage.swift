//
//  AppLanguage.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

enum AppLanguage: Int, CaseIterable, Identifiable {
    case system
    case en
    case zh

    var localizedString: LocalizedStringKey {
        switch self {
        case .system:
            return "Setting_BySystem"
        case .en:
            return "AppLanguage_English"
        case .zh:
            return "AppLanguage_Chinese"
        }
    }

    var id: Self {
        self
    }

    var locale: Locale {
        switch self {
        case .system:
            return .current
        case .zh:
            return .init(identifier: "zh-cn")
        case .en:
            return .init(identifier: "en")
        }
    }
}
