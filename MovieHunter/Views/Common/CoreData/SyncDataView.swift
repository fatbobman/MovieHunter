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
    @FetchRequest(fetchRequest: movieRequest)
    var favoriteMovies: FetchedResults<FavoriteMovie>
    @FetchRequest(fetchRequest: personRequest)
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

    static let movieRequest: NSFetchRequest<FavoriteMovie> = {
        let request = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        request.sortDescriptors = [.init(key: "createTimestamp", ascending: false)]
        request.returnsObjectsAsFaults = false
        return request
    }()

    static let personRequest: NSFetchRequest<FavoritePerson> = {
        let request = NSFetchRequest<FavoritePerson>(entityName: "FavoritePerson")
        request.sortDescriptors = [.init(key: "createTimestamp", ascending: false)]
        request.returnsObjectsAsFaults = false
        return request
    }()
}

extension View {
    func syncCoreData() -> some View {
        background(
            SyncDataView()
        )
    }
}

struct SyncDataView_Previews: PreviewProvider {
    static var previews: some View {
        SyncDataView()
    }
}
