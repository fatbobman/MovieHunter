//
//  Store.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Combine
import Foundation

final class Store: ObservableObject {
    private let configuration = AppConfiguration()

    @Published var state: AppState

    private let environment = AppEnvironment()

    private var effectCancellable: [UUID: AnyCancellable] = [:]

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
                    self?.effectCancellable[uuid] = nil
                },
                receiveValue: { [weak self] in self?.send($0) }
            )
        if !didComplete {
            effectCancellable[uuid] = cancellable
        }
    }

    private let reduce: Reducer<AppState, AppAction, AppEnvironment> = Reducer { state, action, environment in
        switch action {
        // get a notification from Core Data when favorite movie list has changed
        case let .movieChangedFormCoreData(favoriteMovieIDs):
            state.favoriteMovieIDs = favoriteMovieIDs
        // get a notification from Core Data when favorite person list has changed
        case let .personChangedFormCoreData(favoritePersonIDs):
            state.favoritePersonIDs = favoritePersonIDs
        // Tabview's button( TabItem ) has been tapped
        case let .TabItemButtonTapped(destination):
            let oldDestination = state.tabDestination
            switch destination {
            case .movie:
                if oldDestination == .movie && !state.destinations.isEmpty {
                    state.destinations = []
                } else {
                    state.tabDestination = .movie
                }
            case .setting:
                if oldDestination != .setting {
                    state.tabDestination = .setting
                }
            }
        // append a destination in NavigationStack's path
        case let .gotoDestination(destination):
            state.destinations.append(destination)
        // set destination of NavigationStack from root
        case let .setDestination(destinations):
            if state.destinations == destinations {
                break
            }
            if state.destinations.isEmpty {
                state.destinations = destinations
                break
            }
            state.destinations.removeAll()
            return Just(AppAction.updateDestination(to: destinations)).delay(for: .seconds(1), scheduler: DispatchQueue.main).eraseToAnyPublisher()
        case let .updateDestination(destinations):
            state.destinations = destinations
        // update colorScheme
        case let .updateColorScheme(colorScheme):
            state.configuration.colorScheme = colorScheme
        // update favorite movie
        case let .updateMovieWishlist(movieID):
            environment.stack.updateFavoriteMovie(movieID: movieID)
        // update favorite person
        case let .updateFavoritePersonList(personID):
            environment.stack.updateFavoritePerson(personID: personID)
        // update genre list
        case let .updateGenreList(genres):
            state.configuration.genres = genres
        }
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }
    .debug()

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
