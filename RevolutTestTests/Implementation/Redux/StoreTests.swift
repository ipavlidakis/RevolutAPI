//
//  StoreTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class StoreTests: XCTestCase {

    private struct TestAction: ActionProtocol {}

    private lazy var stubReducers: [Reducer]! = [self.reducer, self.reducer]
    private var stubMiddlewares: [StubMiddleware]! = [StubMiddleware()]
    private var stubState: AppState! = .initial
    private lazy var store: RevolutTest.Store! = RevolutTest.Store(
        state: stubState,
        reducers: stubReducers,
        middlewares: stubMiddlewares)

    private var reducerWasCalled: Int! = 0

    override func tearDown() {

        stubReducers = nil
        stubMiddlewares = nil
        store = nil
        reducerWasCalled = nil

        super.tearDown()
    }


    func reducer(
        _ state: AppState,
        _ action: ActionProtocol) -> AppState {

        reducerWasCalled += 1

        return state
    }
}

private extension StoreTests {

    func makeState(
        timer: AppState.TimerState.State = .stopped,
        network: AppState.NetworkState.State = .notRunning) -> AppState {

        return AppState(
            currencies: AppState.CurrenciesState(currencies: [], manualUpdatedCurrencies: []),
            timer: AppState.TimerState(state: timer),
            network: AppState.NetworkState(state: network),
            editing: AppState.EditingState(isEditing: false, hasManuallyBeingUpdated: false))
    }
}

extension StoreTests {

    // MARK: - dispatch

    func test_dispatch_middlewaresWereCalled() {

        stubState = makeState(timer: .isRunning)

        store.dispatch(TestAction())

        stubMiddlewares.forEach { XCTAssertEqual($0.applyWasCalled?.state, stubState) }
    }

    func test_dispatch_reducersWereCalled() {

        stubState = makeState(timer: .isRunning)

        store.dispatch(TestAction())

        XCTAssertEqual(reducerWasCalled, 2)
    }

    // MARK: subscribe
    // .
    // .
    // .
    // .
    // .
    // .
    // .
    // .
    // .
    // .
}
