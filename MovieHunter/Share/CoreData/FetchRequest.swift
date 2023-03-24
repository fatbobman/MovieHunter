//
//  FetchRequest.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/24.
//

import CoreData
import Foundation

extension FavoriteMovie {
    static let movieRequest: NSFetchRequest<FavoriteMovie> = {
        let request = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        request.sortDescriptors = [.init(key: "createTimestamp", ascending: false)]
        request.returnsObjectsAsFaults = false
        return request
    }()

    static let disableRequest: NSFetchRequest<FavoriteMovie> = {
        let request = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        request.sortDescriptors = [.init(key: "createTimestamp", ascending: false)]
        request.predicate = .init(value: false)
        return request
    }()
}

extension FavoritePerson {
    static let personRequest: NSFetchRequest<FavoritePerson> = {
        let request = NSFetchRequest<FavoritePerson>(entityName: "FavoritePerson")
        request.sortDescriptors = [.init(key: "createTimestamp", ascending: false)]
        request.returnsObjectsAsFaults = false
        return request
    }()

    static let disableRequest: NSFetchRequest<FavoritePerson> = {
        let request = NSFetchRequest<FavoritePerson>(entityName: "FavoritePerson")
        request.sortDescriptors = [.init(key: "createTimestamp", ascending: false)]
        request.predicate = .init(value: false)
        return request
    }()
}
