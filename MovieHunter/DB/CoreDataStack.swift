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

    var store: Store?

    let container: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Model")
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

    private var fetchMoviesManager: FetchDataManager<FavoriteMovie>?
    private var fetchPersonManager: FetchDataManager<FavoritePerson>?

    func setup(updatePersons: ((Set<Int>) -> Void)?, updateMovies: ((Set<Int>) -> Void)?) {
        if fetchMoviesManager == nil {
            let request = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
            request.sortDescriptors = [NSSortDescriptor(key: "createTimestamp", ascending: false)]
            fetchMoviesManager = .init(request: request, context: viewContext)
            fetchMoviesManager?.start(by: updateMovies)
        }
        if fetchPersonManager == nil {
            let request = NSFetchRequest<FavoritePerson>(entityName: "FavoritePerson")
            request.sortDescriptors = [NSSortDescriptor(key: "createTimestamp", ascending: false)]
            fetchPersonManager = .init(request: request, context: viewContext)
            fetchPersonManager?.start(by: updatePersons)
        }
    }
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
