//
//  WishlistScrollView.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/20.
//

import CoreData
import Foundation
import SwiftUI
import TMDb

struct WishlistScrollView: View {
    @EnvironmentObject private var store: Store
    @State private var movies = [Movie]()
    @FetchRequest(fetchRequest: movieRequest)
    private var favoriteMovieIDs: FetchedResults<FavoriteMovie>
    @Environment(\.tmdb) private var tmdb

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                if movies.isEmpty {
                    // placeholder 保持高度
                    MovieItem(
                        movie: PreviewData.previewMovie1,
                        category: .movieWishlist,
                        displayType: .portrait(.small)
                    )
                    .opacity(0.001)
                }
                ForEach(movies) { movie in
                    MovieItem(
                        movie: movie,
                        category: .movieWishlist,
                        displayType: .portrait(.small)
                    )
                }
                .transition(.opacity)
            }
            .animation(.default, value: movies)
            .padding(.bottom, 22)
        }
        .scrollContentBackground(.hidden)
        .background(Assets.Colors.rowBackground)
        .safeAreaInset(edge: .leading) {
            Color.clear
                .frame(width: 6)
        }
        .safeAreaInset(edge: .trailing) {
            Color.clear
                .frame(width: 6)
        }
        .task(id: favoriteMovieIDs.count) {
            await loadMovies()
        }
    }

    func loadMovies() async {
        let movies = await withTaskGroup(of: Movie?.self, returning: [Movie?].self) { taskGroup in
            for movieID in favoriteMovieIDs {
                taskGroup.addTask {
                    try? await tmdb.movies.details(forMovie: Int(movieID.movieID))
                }
            }
            var movies = [Movie?]()
            for await result in taskGroup {
                movies.append(result)
            }
            return movies
        }
        self.movies = movies.compactMap { $0 }.sorted(using: KeyPathComparator(\.popularity))
    }

    static let movieRequest: NSFetchRequest<FavoriteMovie> = {
        let request = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        request.sortDescriptors = [.init(key: "createTimestamp", ascending: false)]
        request.returnsObjectsAsFaults = false
        return request
    }()
}

#if DEBUG
    struct WishlistScrollView_Previews: PreviewProvider {
        static var previews: some View {
            WishlistScrollView()
                .environment(\.managedObjectContext, CoreDataStack.share.viewContext)
        }
    }
#endif
