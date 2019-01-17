//
//  TimerReducer.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension RevolutTest {

    static let TimerReducer: Reducer = { state, action in

        guard let action = action as? UpdateTimerStateAction else {

            return state
        }

        return AppState(
            currencies: state.currencies,
            timer: AppState.TimerState(state: action.state),
            network: state.network,
            editing: state.editing
        )
    }
}
