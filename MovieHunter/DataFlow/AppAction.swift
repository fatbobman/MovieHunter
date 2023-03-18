//
//  AppAction.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation

enum AppAction {
    case TabItemButtonTapped(TabDestination)
    /// empty destinations and back to home
    case setDestination(to: Destination)
    /// append one destination into destinations
    case gotoDestionation(Destination)
    // Configuration
    case updateColorScheme(ColorSchemeSetting)
    // Favorite
}
