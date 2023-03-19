//
//  SyncDataView.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import Foundation
import SwiftUI

struct SyncDataView: View {
    @FetchRequest(entity: FavoriteMovie.entity(), sortDescriptors: [.init(key: "createTimestamp", ascending: false)])
    var favoriteMovies: FetchedResults<FavoriteMovie>
    @FetchRequest(entity: FavoritePerson.entity(), sortDescriptors: [.init(key: "createTimestamp", ascending: false)])
    var favoritePersons: FetchedResults<FavoritePerson>
    @EnvironmentObject var store: Store
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

struct SyncDataView_Previews: PreviewProvider {
    static var previews: some View {
        SyncDataView()
    }
}
