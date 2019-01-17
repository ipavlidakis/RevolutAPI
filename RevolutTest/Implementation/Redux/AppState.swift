//
//  AppState.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct AppState: Equatable {

    let currencies: CurrenciesState
    let timer: TimerState
    let network: NetworkState
    let editing: EditingState
}

extension AppState {

    static let initial = AppState(
        currencies: CurrenciesState(currencies: [], manualUpdatedCurrencies: []),
        timer: TimerState(state: .stopped),
        network: NetworkState(state: .notRunning),
        editing: EditingState(isEditing: false, hasManuallyBeingUpdated: false))
}

extension AppState {

    struct CurrenciesState: Equatable {

        let currencies: [CurrencyPrice]
        let manualUpdatedCurrencies: [CurrencyPrice]
    }
}

extension AppState {

    struct TimerState: Equatable {

        enum State { case stopped, isRunning, ticked }

        let state: State
    }
}

extension AppState {

    struct NetworkState: Equatable {

        enum State { case notRunning, isRunning }

        let state: State
    }
}


extension AppState {

    struct EditingState: Equatable {

        let isEditing: Bool
        let hasManuallyBeingUpdated: Bool
    }
}
