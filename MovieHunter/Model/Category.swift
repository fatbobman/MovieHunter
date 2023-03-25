//
//  Category.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import SwiftUI
import TMDb

enum Category: Hashable {
    case nowPlaying
    case popular
    case upComing
    case topRate
    case movieWishlist
    case favoritePerson
    case genre(Genre.ID)
}

extension Category: Identifiable {
    var id: Self { self }
}

extension Category {
    var localizedString: LocalizedStringKey {
        switch self {
        case .nowPlaying:
            return "Category_nowPlaying"
        case .popular:
            return "Category_popular"
        case .upComing:
            return "Category_upComing"
        case .topRate:
            return "Category_topRate"
        case .movieWishlist:
            return "Category_movieWishlist"
        case .favoritePerson:
            return "Category_favoritePerson"
        case .genre(let genreID):
            return Genres(id: genreID)?.localizedString ?? "EmptyLocalizableString"
        }
    }
}

extension Category {
    var destination: Destination {
        switch self {
        case .nowPlaying:
            return .nowPlaying
        case .popular:
            return .popular
        case .upComing:
            return .upcoming
        case .topRate:
            return .topRate
        case .movieWishlist:
            return .wishlist
        case .favoritePerson:
            return .favoritePerson
        case let .genre(genreID):
            return .genre(genreID)
        }
    }

    static let showableCategory: [Category] = [
        .nowPlaying,
        .popular,
        .upComing,
        .topRate,
        .movieWishlist,
        .favoritePerson,
    ]
}
