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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, stack.viewContext)
            #if os(macOS)
                .frame(minWidth: 800, minHeight: 700)
            #endif
        }
        .defaultSize(width: 1024, height: 800)

        #if os(macOS)
            Settings {
                SettingContainer()
            }
        #endif
    }
}
