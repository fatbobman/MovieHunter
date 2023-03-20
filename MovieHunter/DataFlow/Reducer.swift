//
//  Reducer.swift
//  MovieHunter
//
//  Created by Yang Xu on 2023/3/18.
//

import Combine
import Foundation
import SwiftUI

struct Reducer<AppState, AppAction, AppEnvironment> {
    let reduce: (inout AppState, AppAction, AppEnvironment) -> AnyPublisher<AppAction, Never>

    func callAsFunction(
        _ state: inout AppState,
        _ action: AppAction,
        _ environment: AppEnvironment
    ) -> AnyPublisher<AppAction, Never> {
        reduce(&state, action, environment)
    }

    func indexed<LiftedState, LiftedAction, LiftedEnvironment, Key>(
        keyPath: WritableKeyPath<LiftedState, [Key: AppState]>,
        extractAction: @escaping (LiftedAction) -> (Key, AppAction)?,
        embedAction: @escaping (Key, AppAction) -> LiftedAction,
        extractEnvironment: @escaping (LiftedEnvironment) -> AppEnvironment
    ) -> Reducer<LiftedState, LiftedAction, LiftedEnvironment> {
        .init { state, action, environment in
            guard let (index, action) = extractAction(action) else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
            let environment = extractEnvironment(environment)
            return self.optional()
                .reduce(&state[keyPath: keyPath][index], action, environment)
                .map { embedAction(index, $0) }
                .eraseToAnyPublisher()
        }
    }

    func indexed<LiftedState, LiftedAction, LiftedEnvironment>(
        keyPath: WritableKeyPath<LiftedState, [AppState]>,
        extractAction: @escaping (LiftedAction) -> (Int, AppAction)?,
        embedAction: @escaping (Int, AppAction) -> LiftedAction,
        extractEnvironment: @escaping (LiftedEnvironment) -> AppEnvironment
    ) -> Reducer<LiftedState, LiftedAction, LiftedEnvironment> {
        .init { state, action, environment in
            guard let (index, action) = extractAction(action) else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
            let environment = extractEnvironment(environment)
            return self.reduce(&state[keyPath: keyPath][index], action, environment)
                .map { embedAction(index, $0) }
                .eraseToAnyPublisher()
        }
    }

    func optional() -> Reducer<AppState?, AppAction, AppEnvironment> {
        .init { state, action, environment in
            if state != nil {
                return self(&state!, action, environment)
            } else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
        }
    }

    func lift<LiftedState, LiftedAction, LiftedEnvironment>(
        keyPath: WritableKeyPath<LiftedState, AppState>,
        extractAction: @escaping (LiftedAction) -> AppAction?,
        embedAction: @escaping (AppAction) -> LiftedAction,
        extractEnvironment: @escaping (LiftedEnvironment) -> AppEnvironment
    ) -> Reducer<LiftedState, LiftedAction, LiftedEnvironment> {
        .init { state, action, environment in
            let environment = extractEnvironment(environment)
            guard let action = extractAction(action) else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
            let effect = self(&state[keyPath: keyPath], action, environment)
            return effect.map(embedAction).eraseToAnyPublisher()
        }
    }

    static func combine(_ reducers: Reducer...) -> Reducer {
        .init { state, action, environment in
            let effects = reducers.compactMap { $0(&state, action, environment) }
            return Publishers.MergeMany(effects).eraseToAnyPublisher()
        }
    }

    func debug(_ prefix: String = "Reducer Action:") -> Reducer<AppState, AppAction, AppEnvironment> {
        .init { state, action, environment in
            #if DEBUG
                print(prefix, action)
            #endif
            return self(&state, action, environment).eraseToAnyPublisher()
        }
    }
}

class DisposeBag {
    var values: [AnyCancellable] = []
    func add(_ value: AnyCancellable) {
        values.append(value)
    }
}

extension AnyCancellable {
    func add(to bag: DisposeBag) {
        bag.add(self)
    }
}

/*
 声明binding,方便在view中将state中的内容直接bind给view
 调用方法
    private var name: Binding<String> {
        store.binding(for: \.name){ .setName(name:$0) }
    }
 通过toAction:来完成send至reducer的动作
 */
extension Store {
    func binding<Value>(
        for keyPath: KeyPath<AppState, Value>,
        toAction: @escaping (Value) -> AppAction
    ) -> Binding<Value> {
        Binding<Value>(
            get: { self.state[keyPath: keyPath] },
            set: { self.send(toAction($0)) }
        )
    }
}
