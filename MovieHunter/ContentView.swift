//
//  ContentView.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Change") {
                if colorScheme == .dark {
                    store.send(.updateColorScheme(.light))
                } else {
                    store.send(.updateColorScheme(.dark))
                }
            }
            Button("add Favorite") {
                store.send(.updateMovieWishlist(10))
            }
//            Text("\(store.state.favoriteovies.count)")
        }
        .padding()
        .preferredColorScheme(store.state.configuration.colorScheme.colorSchmeme)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Store())
    }
}
