//
//  ContentView.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    var body: some View {
        VStack {
            Home()
                .environment(\.inWishlist) {
                    store.state.favoriteMovieIDs.contains($0)
                }
                .environment(\.goDetailFromHome) { category,movie in
                    store.send(.setDestination(to: [category.destination, .movieDetail(movie)]))
                }
                .environment(\.updateWishlist) {
                    store.send(.updateMovieWishlist($0))
                }
                .environment(\.goCategory) {
                    store.send(.setDestination(to: [$0]))
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Store())
    }
}
