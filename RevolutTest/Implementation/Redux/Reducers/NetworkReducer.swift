//
//  NetworkReducer.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension RevolutTest {

    static let NetworkReducer: Reducer = { state, action in

        guard let action = action as? UpdateNetworkStateAction else {

            return state
        }

        return AppState(
            currencies: state.currencies,
            timer: state.timer,
            network: AppState.NetworkState(state: action.state),
            editing: state.editing
        )
    }
}
