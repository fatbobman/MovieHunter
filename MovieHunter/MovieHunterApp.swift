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
            MovieItemWrapper(displayType: .portrait(.middle), movie: PreviewData.previewMovie)
                .background(
                    SyncDataView()
                )
                .environmentObject(store)
                .preferredColorScheme(store.state.configuration.colorScheme.colorSchmeme)
                .setDeviceStatus()
                .environment(\.managedObjectContext, stack.viewContext)
//                .onAppear{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                        store.send(.onStart)
//                    }
//                }
        }
    }
}
