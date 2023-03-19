//
//  Store.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Combine
import Foundation

final class Store: ObservableObject {
    private let configuration = Configuration()

    @Published private(set) var state: AppState

    private let environment = AppEnvironment()

    private var effectCancellables: [UUID: AnyCancellable] = [:]

    init() {
        state = AppState(configuration: configuration)
    }

    func send(_ action: AppAction) {
        let effect = reduce(&state, action, environment)

        var didComplete = false
        let uuid = UUID()

        let cancellable = effect
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] _ in
                    didComplete = true
                    self?.effectCancellables[uuid] = nil
                },
                receiveValue: { [weak self] in self?.send($0) }
            )
        if !didComplete {
            effectCancellables[uuid] = cancellable
        }
    }

    private let reduce: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
        switch action {
        case let .movieChangedFormCoreData(favoriteMovieIDs):
            state.favoriteMovieIDs = favoriteMovieIDs
        case let .personChangedFormCoreData(favoritePersonIDs):
            state.favoritePersonIDs = favoritePersonIDs
        case let .TabItemButtonTapped(destination):
            let oldDestination = state.tabDesctination
            switch destination {
            case .movie:
                if oldDestination == .movie && !state.destinations.isEmpty {
                    state.destinations = []
                } else {
                    state.tabDesctination = .movie
                }
            case .setting:
                if oldDestination != .setting {
                    state.tabDesctination = .setting
                }
            }
        case let .gotoDestionation(destination):
            state.destinations.append(destination)
        case let .setDestination(destinations):
            state.destinations = destinations
        case let .updateColorScheme(colorScheme):
            state.configuration.colorScheme = colorScheme

        // Favorite
        case let .updateMovieWishlisth(movieID):
            environment.stack.updateFovariteMovie(movieID: movieID)
        case let .updateFavoritePersonList(personID):
            environment.stack.updateFovaritePerson(personID: personID)
        }
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }

    func inWishlist(_ movieID: Int) -> Bool {
        state.favoriteMovieIDs.contains(movieID)
    }

    func isFavoritePerson(_ personID: Int) -> Bool {
        state.favoritePersonIDs.contains(personID)
    }
}

extension Store {
    static let share = Store()
}
