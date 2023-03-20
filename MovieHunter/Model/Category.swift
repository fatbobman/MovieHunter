//
//  Category.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import SwiftUI
import TMDb

enum Category:String,CaseIterable {
    case nowPlaying
    case popular
    case upComing
    case topRate
    case movieWishlist
    case favoritePerson
}

extension Category:Identifiable {
    var id:String { self.rawValue }
}

extension Category {
    var localizedString:LocalizedStringKey {
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
        }
    }
}

extension Category {
    var destination:Destination {
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
        }
    }
}
