//
//  MovieHunterApp.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import SwiftUI

@main
struct MovieHunterApp: App {
    @StateObject var store = Store()
    var body: some Scene {
        WindowGroup {
//            ContentView()
            MovieItemWrapper(displayType: .portrait(.middle), movie: PreviewData.previewMovie)
                .environmentObject(store)
                .preferredColorScheme(store.state.configuration.colorScheme.colorSchmeme)
        }
    }
}
