//
//  TableViewStateHandler.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import UIKit

final class TableViewStateHandler {

    let identifier: UUID = UUID()

    private let store: StoreProtocol
    private weak var tableViewController: TableViewProviding?
    private(set) var adapter: TableViewAdapterProtocol

    private var unsubscribeBlock: UnsubscribeListener?
    private var lastUsedStateHashValue: Int = 0

    init(store: StoreProtocol,
         tableViewController: TableViewProviding,
         adapter: TableViewAdapterProtocol) {

        self.store = store
        self.tableViewController = tableViewController
        self.adapter = adapter

        self.unsubscribeBlock = store.subscribe(self)
        self.adapter.delegate = self
    }

    deinit {

        unsubscribeBlock?()
    }
}

private extension TableViewStateHandler {

    func handleLoadingIndicator(
        with state: AppState.NetworkState.State) {

        guard let navigationItem = tableViewController?.navigationItem else {

            return
        }

        switch state {
        case .isRunning:
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
            activityIndicator.startAnimating()
        case .notRunning:
            navigationItem.rightBarButtonItem = nil
        }
    }
}

extension TableViewStateHandler: ListenerProtocol {

    func stateUpdated() {

        let newState = store.state.currencies

        handleLoadingIndicator(with: store.state.network.state)

        guard
            let tableView = tableViewController?.tableView else { return }

            adapter.update(
                with: newState.manualUpdatedCurrencies,
                tableView: tableView)

    }
}

extension TableViewStateHandler: TableViewAdapterDelegate {

    func willStartEditing() {

        store.dispatch(UpdateEditingAction(isEditing: true, hasManuallyBeingUpdated: false))
        store.dispatch(UpdateTimerStateAction(state: .stopped))
    }

    func didChangeValue(
        to: Double,
        for viewModel: CurrencyPrice) {

        let diff = (to - viewModel.price) / viewModel.price

        let newPrice = viewModel.price + viewModel.price * diff

        print("With \(diff) the price changes from \(viewModel.price) -> \(newPrice)")

        store.dispatch(ManualUpdateCurrenciesAction(diff: diff))
    }

    func willStopEditing() {

        store.dispatch(UpdateEditingAction(isEditing: false, hasManuallyBeingUpdated: false))
        store.dispatch(UpdateTimerStateAction(state: .isRunning))
    }
}
