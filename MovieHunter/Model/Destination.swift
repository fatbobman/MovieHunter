//
//  Destination.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/17.
//

import Foundation
import TMDb

enum Destination: CustomDebugStringConvertible, Identifiable, Hashable, Equatable {
    case upcoming
    case nowPlaying
    case popular
    case topRate
    case wishlist
    case favoritePerson
    case genre(Genre)
    case movieDetail(Movie)
    case personDetail(Person)

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
        case .favoritePerson:
            return "favoritePerson"
        case let .genre(genre):
            return "genre_\(genre.name)"
        case let .movieDetail(movie):
            return "movie_\(movie.id)"
        case let .personDetail(person):
            return "people_\(person.id)"
        }
    }

    var id: String {
        debugDescription
    }
}
