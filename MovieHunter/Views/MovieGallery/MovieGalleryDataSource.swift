//
//  MovieGalleryContainer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/23.
//

import Foundation
import SwiftUI
import TMDb

struct MovieGalleryDataSource: View {
    let category: Category

    @StateObject private var loader = MoviesGalleryLoader()
    @Environment(\.tmdb) private var tmdb
    @FetchRequest
    private var favoriteMovieIDs: FetchedResults<FavoriteMovie>
    private var source: Source
    // movies from wishlist movie ids
    @State private var wishlistMovies = [Movie]()
    private var movies: AnyRandomAccessCollection<Movie> {
        switch source {
        case .tmdb:
            return AnyRandomAccessCollection(loader)
        case .wishlist:
            return AnyRandomAccessCollection(wishlistMovies)
        }
    }
    
    init(category: Category) {
        self.category = category
        switch category {
        case .movieWishlist:
            _favoriteMovieIDs = FetchRequest(fetchRequest: FavoriteMovie.movieRequest)
            source = .wishlist
        default:
            source = .tmdb
            _favoriteMovieIDs = FetchRequest(fetchRequest: FavoriteMovie.disableRequest)
        }
    }

    var body: some View {
        List {
            ForEach(movies) { movie in
                MovieItem(movie: movie, displayType: .landscape)
            }
        }
        .onAppear {
            switch source {
            case .tmdb:
                loader.setLoader(category: category, tmdb: tmdb)
            case .wishlist:
                break
            }
        }
        .task(id: favoriteMovieIDs.count) {
            guard source == .wishlist else { return }
            wishlistMovies = await Movie.loadWishlistMovieByIDs(tmdb: tmdb, movieIDs: Array(favoriteMovieIDs.map { Int($0.movieID) })) // loadMovies(movieIDs: Array(favoriteMovieIDs.map{Int($0.movieID)}))
        }
    }
}

private extension MovieGalleryDataSource {
    enum Source {
        case tmdb
        case wishlist
    }
}

/*
 // 三种数据源的包装器： Tmdb、wishlist、favoritePerson
  List
  Grid

  NavigationStack
  MovieDetail
  PersonDetail
  TabView
  Settings
  NavigationSplitView

 */
