//
//  FetchRequestController.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/19.
//

import CoreData
import Foundation

protocol SearchableID: NSManagedObject {
    var searchableID: Int { get }
}

extension FavoriteMovie: SearchableID {
    var searchableID: Int {
        Int(movieID)
    }
}

extension FavoritePerson: SearchableID {
    var searchableID: Int {
        Int(personID)
    }
}

final class FetchDataManager<T: SearchableID>: NSObject, NSFetchedResultsControllerDelegate {
    private var update: ((Set<Int>) -> Void)?
    private var request: NSFetchRequest<T>
    private var controller: NSFetchedResultsController<T>!
    private let context: NSManagedObjectContext

    init(request: NSFetchRequest<T>, context: NSManagedObjectContext) {
        self.request = request
        self.context = context
    }

    func start(by update: ((Set<Int>) -> Void)?) {
        self.update = update
        controller = .init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        try? controller.performFetch()
        let result = controller.fetchedObjects ?? []
        self.update?(Set(result.map { $0.searchableID }))
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let result = (controller.fetchedObjects ?? []) as? [T] {
            update?(Set(result.map { $0.searchableID }))
        }
    }
}
