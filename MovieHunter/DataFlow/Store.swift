//
//  Store.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Combine
import Foundation

final class Store: ObservableObject {
    private let favorite = Favorite()
    private let configuration = Configuration()

    @Published private(set) var state: AppState

    private let environment: () = ()

    private var effectCancellables: [UUID: AnyCancellable] = [:]

    init() {
        state = AppState(favorite: favorite, configuration: configuration)
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

    private let reduce: Reducer<AppState, AppAction, Void> = Reducer { state, action, _ in
        switch action {
        case .TabItemButtonTapped:
            break
        case .updateColorScheme(let colorScheme):
            state.configuration.colorScheme = colorScheme
        }
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }
}
