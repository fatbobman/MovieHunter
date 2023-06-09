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
    @StateObject private var store = Store()
    @StateObject private var appConfiguration = AppConfiguration.share
    @State private var containerName = ""
    private let category: Category?
    init(category: Category? = nil) {
        self.category = category
    }

    var body: some View {
        VStack {
            #if !os(macOS)
                TabViewContainer()
            #else
                StackContainer()
            #endif
        }
        .if(containerName != ""){
            $0.overlayContainer(containerName, containerConfiguration: ContainerConfiguration.share)
        }
        .environment(\.containerName, containerName)
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
        .preferredColorScheme(appConfiguration.colorScheme.colorScheme)
        .environment(\.locale, appConfiguration.appLanguage.locale)
        .setDeviceStatus()
        #if os(macOS)
            .frame(minWidth: 800, minHeight: 700)
        #endif
            .task {
                if let category {
                    store.send(.setDestination(to: [category.destination]))
                }
            }
            .onAppear {
                containerName = UUID().uuidString
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        #if os(iOS)
            ContentView()
                .environmentObject(Store())
                .environment(\.deviceStatus, .compact)
                .previewDevice(.iPhoneName)

            ContentView()
                .environmentObject(Store())
                .environment(\.deviceStatus, .regular)
                .previewDevice(.iPadName)
        #else
            ContentView()
                .environmentObject(Store())
                .environment(\.deviceStatus, .macOS)
        #endif
    }
}
