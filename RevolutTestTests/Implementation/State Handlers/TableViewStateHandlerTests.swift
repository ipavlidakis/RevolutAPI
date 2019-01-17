//
//  TableViewStateHandlerTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class TableViewStateHandlerTests: XCTestCase {

    private var stubStore: StubStore! = StubStore()
    private var stubTableViewController: StubUITableViewController! = StubUITableViewController()
    private var stubTableViewAdapter: StubTableViewAdapter! = StubTableViewAdapter()
    private var stateHandler: TableViewStateHandler!

    override func setUp() {

        super.setUp()

        stateHandler = TableViewStateHandler(
            store: stubStore,
            tableViewController: stubTableViewController,
            adapter: stubTableViewAdapter)
    }

    override func tearDown() {

        stubStore = nil
        stubTableViewController = nil
        stubTableViewAdapter = nil
        stateHandler = nil

        super.tearDown()
    }
}

private extension TableViewStateHandlerTests {

    func makeState(
        currencies: [CurrencyPrice] = [],
        manualUpdatedCurrencies: [CurrencyPrice] = [],
        network: AppState.NetworkState.State = .notRunning,
        isEditing: Bool = false,
        hasManuallyBeingUpdated: Bool = false) -> AppState {

        return AppState(
            currencies: AppState.CurrenciesState(currencies: currencies, manualUpdatedCurrencies: manualUpdatedCurrencies),
            timer: AppState.TimerState(state: .stopped),
            network: AppState.NetworkState(state: network),
            editing: AppState.EditingState(isEditing: isEditing, hasManuallyBeingUpdated: hasManuallyBeingUpdated))
    }
}


extension TableViewStateHandlerTests {

    // MARK: - init

    func test_init_setsDelegateOnAdapter() {

        XCTAssert((stubTableViewAdapter.delegate as? TableViewStateHandler) === stateHandler)
    }
}

extension TableViewStateHandlerTests {

    // MARK: - stateUpdated

    func test_stateUpdated_networkIsRunning_addsActivityIndicatorOnNavigationItem() {

        stubStore.stubState = makeState(network: .isRunning)

        stateHandler.stateUpdated()

        XCTAssertNotNil(stubTableViewController.navigationItem.rightBarButtonItem?.customView as? UIActivityIndicatorView)
    }

    func test_stateUpdated_networkIsNotRunning_setsRightBarButtonItemToNil() {

        stubStore.stubState = makeState(network: .isRunning)

        stateHandler.stateUpdated()

        stubStore.stubState = makeState(network: .notRunning)

        stateHandler.stateUpdated()

        XCTAssertNil(stubTableViewController.navigationItem.rightBarButtonItem)
    }

    func test_stateUpdated_updateWasCalledOnAdapterWithExpectedItems() {

        let item = CurrencyPrice(code: "Code", description: "Code", price: 10)
        stubStore.stubState = makeState(manualUpdatedCurrencies: [item])

        stateHandler.stateUpdated()

        XCTAssertEqual(stubTableViewAdapter.updateWasCalled?.items, [item])
        XCTAssertEqual(stubTableViewAdapter.updateWasCalled?.tableView, stubTableViewController.tableView)
    }
}

extension TableViewStateHandlerTests {

    // MARK: - willStartEditing

    func test_willStartEditing_dispatchesUpdateEditingActionWithIsEditingTrueAndHasManualUpdatesFalse() {

        stateHandler.willStartEditing()

        XCTAssert((stubStore.dispatchCalledWithActions.first as? UpdateEditingAction)?.isEditing ?? false)
        XCTAssertFalse((stubStore.dispatchCalledWithActions.first as? UpdateEditingAction)?.hasManuallyBeingUpdated ?? true)
    }

    func test_willStartEditing_dispatchesUpdateTimerStateActionWithStateStopped() {

        stateHandler.willStartEditing()

        XCTAssertEqual((stubStore.dispatchCalledWithActions.last as? UpdateTimerStateAction)?.state, .stopped)
    }

    // MARK: - didChangeValue

    func test_didChangeValue_dispatchesManualUpdateCurrenciesActionWithExpectedDiff() {

        let expected: Double = 0.5
        let item = CurrencyPrice(code: "", description: "", price: 10)

        stateHandler.didChangeValue(
            to: 15, for: item)

        XCTAssertEqual((stubStore.dispatchCalledWithActions.last as? ManualUpdateCurrenciesAction)?.diff, expected)
    }

    // MARK: - willStopEditing

    func test_willStopEditing_dispatchesUpdateEditingActionWithIsEditingFalseAndHasManualUpdatesFalse() {

        stateHandler.willStopEditing()

        XCTAssertFalse((stubStore.dispatchCalledWithActions.first as? UpdateEditingAction)?.isEditing ?? true)
        XCTAssertFalse((stubStore.dispatchCalledWithActions.first as? UpdateEditingAction)?.hasManuallyBeingUpdated ?? true)
    }

    func test_willStopEditing_dispatchesUpdateTimerStateActionWithStateIsRunning() {

        stateHandler.willStopEditing()

        XCTAssertEqual((stubStore.dispatchCalledWithActions.last as? UpdateTimerStateAction)?.state, .isRunning)
    }
}
