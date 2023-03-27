//
//  ContentView.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import Combine
import SwiftUI
import SwiftUIOverlayContainer

struct ContentView: View {
    @EnvironmentObject var store:Store
    @State var id = UUID()
    @StateObject private var c = AppConfiguration.share
    var body: some View {
        VStack {
            #if !os(macOS)
                TabViewContainer()
            #else
                StackContainer()
            #endif
        }
        .overlayContainer(backdropContainerName, containerConfiguration: ContainerConfiguration.share)
        .environment(\.inWishlist) {
            store.state.favoriteMovieIDs.contains($0)
        }
        .environment(\.goDetailFromHome) { category, movie in
            store.send(.setDestination(to: [category.destination, .movieDetail(movie)]))
        }
        .environment(\.updateWishlist) {
            store.send(.updateMovieWishlist($0))
        }
        .environment(\.goCategory) {
            store.send(.setDestination(to: [$0]))
        }
        .environment(\.goDetailFromCategory) {
            store.send(.gotoDestination(.movieDetail($0)))
        }
        .syncCoreData() // 同步 favorite 数据
        .environmentObject(store)
        .preferredColorScheme(c.colorScheme.colorScheme)
        .environment(\.locale, c.appLanguage.locale)
        .setDeviceStatus()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Store())
    }
}
