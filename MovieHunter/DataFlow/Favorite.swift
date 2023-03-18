//
//  Favorite.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import CloudStorage
import Combine
import Foundation

final class Favorite: ObservableObject {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    @CloudStorage("movies") private var movies_storage: Data = .init()
    var movies: [Int] {
        get {
            guard let movies = try? decoder.decode([Int].self, from: movies_storage) else { return [] }
            return movies
        }
        set {
            guard let data = try? encoder.encode(newValue) else { return }
            movies_storage = data
        }
    }

    @CloudStorage("person") private var person_storage: Data = .init()
    var person: [Int] {
        get {
            guard let person = try? decoder.decode([Int].self, from: person_storage) else { return [] }
            return person
        }
        set {
            guard let data = try? encoder.encode(newValue) else { return }
            person_storage = data
        }
    }
}
