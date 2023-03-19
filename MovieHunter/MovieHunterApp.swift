//
//  MovieHunterApp.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import SwiftUI

@main
struct MovieHunterApp: App {
    let stack = CoreDataStack.share
    @StateObject var store = Store.share
    var body: some Scene {
        WindowGroup {
//            ContentView()
            MovieNowPlayingContainer()
//            MovieItemWrapper(displayType: .portrait(.middle), movie: PreviewData.previewMovie)
                .syncCoreData() // 同步 favorite 数据
                .environmentObject(store)
                .preferredColorScheme(store.state.configuration.colorScheme.colorSchmeme)
                .setDeviceStatus()
                .environment(\.managedObjectContext, stack.viewContext)
        }
    }
}
