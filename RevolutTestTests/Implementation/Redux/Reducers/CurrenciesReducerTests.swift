//
//  CurrenciesReducerTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class CurrenciesReducerTests: XCTestCase {

    // MARK: - execute

    func test_execute_actionIsUpdateCurrenciesAction_updatesState() {

        let items = [CurrencyPrice(code: "", description: "", price: 10)]
        let action = UpdateCurrenciesAction(newCurrencies: items)

        let newState = RevolutTest.CurrenciesReducer(AppState.initial, action)

        XCTAssertEqual(newState.currencies.currencies, items)
        XCTAssertEqual(newState.currencies.manualUpdatedCurrencies, items)
    }

    func test_execute_actionIsManualUpdateCurrenciesAction_updatesState() {

        let items = [CurrencyPrice(code: "", description: "", price: 10)]
        let firstAction = UpdateCurrenciesAction(newCurrencies: items)
        let action = ManualUpdateCurrenciesAction(diff: 0.5)

        let state = RevolutTest.CurrenciesReducer(AppState.initial, firstAction)
        let newState = RevolutTest.CurrenciesReducer(state, action)

        XCTAssertEqual(newState.currencies.currencies, items)
        XCTAssertEqual(newState.currencies.manualUpdatedCurrencies.first?.price, 15)
    }
}
