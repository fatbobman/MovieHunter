//
//  AppLanguage.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/25.
//

import Foundation
import SwiftUI

enum AppLanguage: Int, CaseIterable, Identifiable {
    case en
    case zh
    case system

    var localizedString: LocalizedStringKey {
        switch self {
        case .en:
            return "AppLanguage_English"
        case .zh:
            return "AppLanguage_Chinese"
        case .system:
            return "Setting_BySystem"
        }
    }

    var id: Self {
        self
    }

    var locale: Locale {
        switch self {
        case .system:
            return .autoupdatingCurrent
        case .zh:
            return .init(identifier: "zh-cn")
        case .en:
            return .init(identifier: "en")
        }
    }
}
