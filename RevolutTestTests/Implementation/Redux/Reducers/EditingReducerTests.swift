//
//  EditingReducerTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class EditingReducerTests: XCTestCase {

    // MARK: - execute

    func test_execute_actionIsUpdateEditingActionAction_updatesState() {

        let action = UpdateEditingAction(isEditing: true, hasManuallyBeingUpdated: false)

        let newState = RevolutTest.EditingReducer(AppState.initial, action)

        XCTAssert(newState.editing.isEditing)
        XCTAssertFalse(newState.editing.hasManuallyBeingUpdated)
    }

    func test_execute_actionIsManualUpdateCurrenciesAction_updatesState() {

        let action = ManualUpdateCurrenciesAction(diff: 10)

        let newState = RevolutTest.EditingReducer(AppState.initial, action)

        XCTAssert(newState.editing.isEditing)
        XCTAssert(newState.editing.hasManuallyBeingUpdated)
    }
}
