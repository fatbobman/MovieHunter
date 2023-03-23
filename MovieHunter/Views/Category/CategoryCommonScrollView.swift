//
//  CategoryCommonScrollView.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/20.
//

import Foundation
import SwiftUI
import TMDb

struct CategoryCommonScrollView: View {
    let category: Category
    @State private var movies = [Movie]()
    @Environment(\.tmdb) private var tmdb
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(movies) { movie in
                    MovieItemWrapper(
                        movie: movie,
                        category: category,
                        displayType: .portrait(.small)
                    )
                }
            }
            .padding(.bottom, 22)
        }
        #if !os(tvOS)
        .scrollContentBackground(.hidden)
        #endif
        .safeAreaInset(edge: .leading) {
            Color.clear
                .frame(width: 6)
        }
        .safeAreaInset(edge: .trailing) {
            Color.clear
                .frame(width: 6)
        }
        .task {
            switch category {
            case .nowPlaying, .movieWishlist, .favoritePerson:
                return
            case .popular:
                if let result = try? await tmdb.movies.popular(page: 1) {
                    movies = Array(result.results.prefix(10))
                }
            case .upComing:
                if let result = try? await tmdb.movies.upcoming(page: 1) {
                    movies = Array(result.results.prefix(10))
                }
            case .topRate:
                if let result = try? await tmdb.movies.topRated(page: 1) {
                    movies = Array(result.results.prefix(10))
                }
            default:
                break
            }
        }
    }
}

#if DEBUG
    struct CategoryCommonScrollView_Previews: PreviewProvider {
        static var previews: some View {
            CategoryCommonScrollView(category: .popular)
        }
    }
#endif
