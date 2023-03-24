//
//  SyncDataView.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import CoreData
import Foundation
import SwiftUI

struct SyncDataView: View {
    @FetchRequest(fetchRequest: FavoriteMovie.movieRequest)
    private var favoriteMovies: FetchedResults<FavoriteMovie>
    @FetchRequest(fetchRequest: FavoritePerson.personRequest)
    private var favoritePersons: FetchedResults<FavoritePerson>
    @EnvironmentObject private var store: Store
    var body: some View {
        Color.clear
            .task(id: favoriteMovies.count) {
                let ids = Set(favoriteMovies.map { Int($0.movieID) })
                store.send(.movieChangedFormCoreData(ids))
            }
            .task(id: favoritePersons.count) {
                let ids = Set(favoritePersons.map { Int($0.personID) })
                store.send(.personChangedFormCoreData(ids))
            }
    }
}

extension View {
    func syncCoreData() -> some View {
        background(
            SyncDataView()
        )
    }
}

#if DEBUG
    struct SyncDataView_Previews: PreviewProvider {
        static var previews: some View {
            SyncDataView()
                .environmentObject(Store.share)
                .environment(\.managedObjectContext, CoreDataStack.share.viewContext)
        }
    }
#endif
