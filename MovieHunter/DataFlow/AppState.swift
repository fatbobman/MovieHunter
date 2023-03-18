//
//  AppState.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Foundation

struct AppState {
    let favorite:Favorite
    let configuration:Configuration
    
    var destinations = [Destination]()
    var topDestination:Destination? {
        destinations.first
    }
    
    var tabDesctination:TabDestination = .movie
    
    init(favorite: Favorite, configuration: Configuration) {
        self.favorite = favorite
        self.configuration = configuration
    }
}
