//
//  Store.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension RevolutTest {

    final class Store {

        private let reducer: Reducer
        private let middlewares: [MiddlewareProtocol]

        private var listeners: [ListenerProtocol]

        private(set) var state: AppState { didSet { listeners.forEach { $0.stateUpdated() } } }

        init(state: AppState,
             reducers: [Reducer],
             middlewares: [MiddlewareProtocol] = [],
             listeners: [ListenerProtocol] = []) {

            self.reducer = Store.combine(reducers)
            self.middlewares = middlewares
            self.listeners = listeners

            self.state = state
        }
    }
}

private extension RevolutTest.Store {

    static func combine(
        _ reducers: [Reducer]) -> Reducer {

        return { state, action in

            return reducers.reduce(state) { $1($0, action) }
        }
    }
}

extension RevolutTest.Store: StoreProtocol {

    func dispatch(
        _ action: ActionProtocol) {

        let initialState = state

        middlewares.forEach { $0.apply(initialState, action) }

        state = reducer(initialState, action)
    }

    func subscribe(
        _ listener: ListenerProtocol) -> UnsubscribeListener {

        listeners.append(listener)

        return { [weak self] in

            guard let self = `self` else { return }

            self.listeners = self.listeners
                .filter { $0.identifier != listener.identifier }
        }
    }
}
