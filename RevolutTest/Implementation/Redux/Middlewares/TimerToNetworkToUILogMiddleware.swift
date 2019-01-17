//
//  TimerToNetworkToUILogMiddleware.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

struct TimerToNetworkToUILogMiddleware: MiddlewareProtocol {

    func apply(
        _ state: AppState,
        _ action: ActionProtocol) {

        switch action {
        case let timerAction as UpdateTimerStateAction:
            print("TimerState is changing from \(state.timer.state) to \(timerAction.state)")
        case let networkAction as UpdateNetworkStateAction:
            print("NetworkState is changing from \(state.network.state) to \(networkAction.state)")
        case let currenciesAction as UpdateCurrenciesAction:
            print("CurrenciesState is changing from hashValue \(state.currencies.currencies.hashValue) to \(currenciesAction.newCurrencies.hashValue)")
        default:
            break
        }
    }
}
