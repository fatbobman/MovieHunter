//
//  AppState.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation

struct AppState {
    let configuration: AppConfiguration

    var destinations = [Destination]()
    var topDestination: Destination? {
        destinations.first
    }

    var favoriteMovieIDs = Set<Int>()
    var favoritePersonIDs = Set<Int>()

    var tabDestination: TabDestination = .movie

    init(configuration: AppConfiguration) {
        self.configuration = configuration
    }
}
