//
//  AppAction.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation

enum AppAction {
    /// favorite movie data update from Core Data
    case movieChangedFormCoreData(Set<Int>)
    /// favorite person data update from Core Data
    case personChangedFormCoreData(Set<Int>)
    /// switch tabView
    case TabItemButtonTapped(TabDestination)
    /// empty destinations and back to home
    case setDestination(to: [Destination])
    /// append one destination into destinations
    case gotoDestionation(Destination)
    // Configuration
    case updateColorScheme(ColorSchemeSetting)
    // Favorite
    case updateMovieWishlisth(Int)
    case updateFavoritePersonList(Int)
}
