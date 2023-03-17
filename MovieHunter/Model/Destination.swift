//
//  Destination.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/17.
//

import Foundation
import TMDb

enum Destination:CustomDebugStringConvertible,Identifiable,Hashable,Equatable {
    case upcoming
    case nowPlaying
    case popular
    case topRate
    case wishlist
    case genre(Genre)
    case home
    case movieDetail(Movie)
    case peopleDetail(Person)
    
    var debugDescription: String {
        switch self {
        case .upcoming:
            return "upcoming"
        case .nowPlaying:
            return "nowPlaying"
        case .popular:
            return "popular"
        case .topRate:
            return "topRate"
        case .wishlist:
            return "wishlist"
        case .genre(let genre):
            return "genre_\(genre.name)"
        case .home:
            return "home"
        case .movieDetail(let movie):
            return "movie_\(movie.id)"
        case .peopleDetail(let person):
            return "people_\(person.id)"
        }
    }
    
    var id: String {
        debugDescription
    }
}
