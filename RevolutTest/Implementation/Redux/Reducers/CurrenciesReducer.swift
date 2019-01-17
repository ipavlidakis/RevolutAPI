//
//  CurrenciesReducer.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension RevolutTest {

    static let CurrenciesReducer: Reducer = { state, action in

        switch action {

        case let updateCurrenciesAction as UpdateCurrenciesAction:

            return AppState(
                currencies: AppState.CurrenciesState(
                    currencies: updateCurrenciesAction.newCurrencies,
                    manualUpdatedCurrencies: updateCurrenciesAction.newCurrencies),
                timer: state.timer,
                network: state.network,
                editing: state.editing
            )
        case let manualUpdateCurrenciesAction as ManualUpdateCurrenciesAction:

            let newCurrencies = state.currencies.currencies.map { CurrencyPrice(
                code: $0.code,
                description: $0.description,
                price: $0.price + $0.price * manualUpdateCurrenciesAction.diff) }

            return AppState(
                currencies: AppState.CurrenciesState(
                    currencies: state.currencies.currencies,
                    manualUpdatedCurrencies: newCurrencies),
                timer: state.timer,
                network: state.network,
                editing: state.editing)
        default:

            return state

        }
    }
}
