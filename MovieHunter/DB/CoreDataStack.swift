//
//  CoreDataStack.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import CoreData
import Foundation
import TMDb

final class CoreDataStack {
    static let share = CoreDataStack()

    lazy var container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Model")

        let desc = container.persistentStoreDescriptions.first!
        desc.setOption(true as NSNumber,
                       forKey: NSPersistentHistoryTrackingKey)
        desc.setOption(true as NSNumber,
                       forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        if !allowCloudKitSync {
            desc.cloudKitContainerOptions = nil
        }
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("\(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    let allowCloudKitSync: Bool = {
        let arguments = ProcessInfo.processInfo.arguments
        var allow = true
        for index in 0 ..< arguments.count - 1 where arguments[index] == "-AllowCloudKitSync" {
            allow = arguments.count >= (index + 1) ? arguments[index + 1] == "1" : true
            break
        }
        return allow
    }()
}

extension CoreDataStack {
    func updateFovariteMovie(movieID: Int) {
        container.performBackgroundTask { context in
            let request = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
            request.fetchLimit = 1
            request.predicate = NSPredicate(format: "movieID = %d", movieID)
            request.sortDescriptors = [NSSortDescriptor(key: "createTimestamp", ascending: true)]
            let result = try? context.fetch(request).first
            if let movie = result {
                context.delete(movie)
                try? context.save()
            } else {
                let favoriteMovie = FavoriteMovie(context: context)
                favoriteMovie.movieID = Int64(movieID)
                favoriteMovie.createTimestamp = .now
                try? context.save()
            }
        }
    }

    func updateFovaritePerson(personID: Int) {
        container.performBackgroundTask { context in
            let request = NSFetchRequest<FavoritePerson>(entityName: "FavoritePerson")
            request.fetchLimit = 1
            request.predicate = NSPredicate(format: "personID = %d", personID)
            request.sortDescriptors = [NSSortDescriptor(key: "createTimestamp", ascending: true)]
            let result = try? context.fetch(request).first
            if let movie = result {
                context.delete(movie)
                try? context.save()
            } else {
                let favoritePerson = FavoritePerson(context: context)
                favoritePerson.personID = Int64(personID)
                favoritePerson.createTimestamp = .now
                try? context.save()
            }
        }
    }
}
