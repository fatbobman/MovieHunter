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
//    @StateObject var store = Store.share
    var body: some Scene {
        WindowGroup {
            ContentView()
//            MovieGalleryDataSource(category:.genre(12))
                .environment(\.managedObjectContext, stack.viewContext)
        }
        
        #if os(macOS)
        Settings {
            SettingContainer()
//                .environmentObject(Store.share)
        }
        #endif
    }
}
