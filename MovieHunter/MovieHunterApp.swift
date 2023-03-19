//
//  MovieHunterApp.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/16.
//

import SwiftUI

@main
struct MovieHunterApp: App {
    @State var stack = CoreDataStack.share
    @StateObject var store = Store.share
    var body: some Scene {
        WindowGroup {
//            ContentView()
            MovieItemWrapper(displayType: .portrait(.middle), movie: PreviewData.previewMovie)
                .environmentObject(store)
                .preferredColorScheme(store.state.configuration.colorScheme.colorSchmeme)
                .setDeviceStatus()
                .environment(\.managedObjectContext, stack.viewContext)
                .onAppear{
                    store.send(.onStart)
                }
        }
    }
}
