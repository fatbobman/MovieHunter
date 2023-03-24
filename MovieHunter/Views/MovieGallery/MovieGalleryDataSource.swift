//
//  MovieGalleryDataSource.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/24.
//

import Foundation
import SwiftUI
import TMDb

//struct DataSourceForGallery: DynamicProperty {
//    @Environment(\.tmdb) private var tmdb
//    @StateObject private var loader: MoviesGalleryLoader
//    @FetchRequest
//    private var favoriteMovies: FetchedResults<FavoriteMovie>
////    @FetchRequest
////    private var favoritePersons: FetchedResults<FavoritePerson>
//    private let source: Source
//
//    var movies:some RandomAccessCollection<Movie>{
//        switch source {
//        case .tmdb(let category):
//            return loader
//        case .wishlist:
//            return favoriteMovies
//        }
//    }
//    
//    init(category: Category) {
//        switch category {
////        case .favoritePerson:
////            _favoritePersons = .init(fetchRequest: FavoritePerson.personRequest)
////            _favoriteMovies = .init(fetchRequest: FavoriteMovie.disableRequest)
////            source = .person
//        case .movieWishlist:
//            _favoriteMovies = .init(fetchRequest: FavoriteMovie.movieRequest)
////            _favoritePersons = .init(fetchRequest: FavoritePerson.disableRequest)
//            source = .wishlist
//        default:
////            _favoritePersons = .init(fetchRequest: FavoritePerson.disableRequest)
//            _favoriteMovies = .init(fetchRequest: FavoriteMovie.disableRequest)
//            source = .tmdb(category)
//        }
//        _loader = .init(wrappedValue: .init())
//    }
//
//    func update() {
//        switch source {
//        case .tmdb(let category):
//            if !loader.loaded {
//                loader.setLoader(category: category, tmdb: tmdb)
//            }
//        default:
//            break
//        }
//    }
//
//    enum Source {
//        case tmdb(Category)
////        case person
//        case wishlist
//    }
//}
