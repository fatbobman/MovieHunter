//
//  AppState.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation

struct AppState {
    let configuration: Configuration

    var destinations = [Destination]()
    var topDestination: Destination? {
        destinations.first
    }

    var favoriteMovieIDs = Set<Int>()
    var favoritePersonIDs = Set<Int>()

    var tabDestination: TabDestination = .movie

    init(configuration: Configuration) {
        self.configuration = configuration
    }
}
