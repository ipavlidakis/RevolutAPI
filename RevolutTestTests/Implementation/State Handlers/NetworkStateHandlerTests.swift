//
//  NetworkStateHandlerTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class NetworkStateHandlerTests: XCTestCase {

    private var stubStore: StubStore! = StubStore()
    private var stubCurrenciesFetcher: StubCurrenciesFetcher! = StubCurrenciesFetcher()
    private lazy var stateHandler: NetworkStateHandler! = NetworkStateHandler(
        store: stubStore,
        fetcher: stubCurrenciesFetcher)

    override func tearDown() {

        stubStore = nil
        stubCurrenciesFetcher = nil
        stateHandler = nil

        super.tearDown()
    }
}

private extension NetworkStateHandlerTests {

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

extension NetworkStateHandlerTests {

    // MARK: - stateUpdated

    func test_stateUpdated_timerTickedNetworkNotRunning_dispatchesUpdateNetworkStateActionWithStateRunning() {

        stubStore.stubState = makeState(timer: .ticked, network: .notRunning)

        stateHandler.stateUpdated()

        XCTAssertEqual((stubStore.dispatchCalledWithActions.first as? UpdateNetworkStateAction)?.state, .isRunning)
    }

    func test_stateUpdated_timerTickedNetworkNotRunning_fetchCurrenciesCalled() {

        stubStore.stubState = makeState(timer: .ticked, network: .notRunning)

        stateHandler.stateUpdated()

        XCTAssertNotNil(stubCurrenciesFetcher.fetchCurrenciesWasCalledWithCompletionBlock)
    }

    func test_stateUpdated_fetchCurrenciesCompletesWithError_dispatchesUpdateNetworkStateActionWithStateNotRunning() {

        stubStore.stubState = makeState(timer: .ticked, network: .notRunning)

        stateHandler.stateUpdated()
        stubCurrenciesFetcher.fetchCurrenciesWasCalledWithCompletionBlock?([], NSError())

        XCTAssertEqual((stubStore.dispatchCalledWithActions.last as? UpdateNetworkStateAction)?.state, .notRunning)
    }

    func test_stateUpdated_fetchCurrenciesCompletesWithNoError_dispatchesUpdateNetworkStateActionWithStateNotRunning() {

        stubStore.stubState = makeState(timer: .ticked, network: .notRunning)

        stateHandler.stateUpdated()
        stubCurrenciesFetcher.fetchCurrenciesWasCalledWithCompletionBlock?([], nil)

        XCTAssertEqual((stubStore.dispatchCalledWithActions[1] as? UpdateNetworkStateAction)?.state, .notRunning)
    }

    func test_stateUpdated_fetchCurrenciesCompletesWithNoError_dispatchesUpdateCurrenciesActionsWithNewCurrencies() {

        stubStore.stubState = makeState(timer: .ticked, network: .notRunning)
        let item = CurrencyPrice(code: "", description: "", price: 10)

        stateHandler.stateUpdated()
        stubCurrenciesFetcher.fetchCurrenciesWasCalledWithCompletionBlock?([item], nil)

        XCTAssertEqual((stubStore.dispatchCalledWithActions.last as? UpdateCurrenciesAction)?.newCurrencies, [item])
    }
}
