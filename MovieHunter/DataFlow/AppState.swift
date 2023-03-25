//
//  AppState.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation

struct AppState {
    var destinations = [Destination]()
    var favoriteMovieIDs = Set<Int>()
    var favoritePersonIDs = Set<Int>()
    var tabDestination: TabDestination = .movie
}
