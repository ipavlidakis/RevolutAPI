//
//  EditingReducer.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

extension RevolutTest {

    static let EditingReducer: Reducer = { state, action in

        switch action {

        case let updateEditingAction as UpdateEditingAction:

            return AppState(
                currencies: state.currencies,
                timer: state.timer,
                network: state.network,
                editing: AppState.EditingState(isEditing: updateEditingAction.isEditing, hasManuallyBeingUpdated: false))
        case let manualUpdateEditingAction as ManualUpdateCurrenciesAction:

            return AppState(
                currencies: state.currencies,
                timer: state.timer,
                network: state.network,
                editing: AppState.EditingState(isEditing: true, hasManuallyBeingUpdated: true))
        default:

            return state
        }
    }
}
