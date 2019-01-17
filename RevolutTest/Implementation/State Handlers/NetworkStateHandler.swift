//
//  TimerStateUpdatesListener.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

final class NetworkStateHandler {

    private let store: StoreProtocol
    private let fetcher: CurrenciesFetching

    let identifier: UUID = UUID()

    private var unsubscribeBlock: UnsubscribeListener?

    init(store: StoreProtocol,
         fetcher: CurrenciesFetching) {

        self.store = store
        self.fetcher = fetcher

        self.unsubscribeBlock = store.subscribe(self)
    }
}

extension NetworkStateHandler: ListenerProtocol {

    func stateUpdated() {

        switch (store.state.timer.state, store.state.network.state) {
        case (.ticked, .notRunning):

            store.dispatch(UpdateNetworkStateAction(state: .isRunning))
            fetcher.fetchCurrencies { [weak self] (currencies, error) in

                self?.store.dispatch(UpdateNetworkStateAction(state: .notRunning))

                guard error == nil else { return }

                self?.store.dispatch(UpdateCurrenciesAction(newCurrencies: currencies))
            }
        default: break
        }
    }
}
