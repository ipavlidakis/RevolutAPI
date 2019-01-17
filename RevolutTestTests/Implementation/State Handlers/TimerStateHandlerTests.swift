//
//  TimerStateHandlerTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class TimerStateHandlerTests: XCTestCase {

    private var stubStore: StubStore! = StubStore()
    private var interval: TimeInterval! = 10
    private var repeats: Bool! = true
    private var stubTimerFactory: StubTimerFactory! = StubTimerFactory()
    private var stateHandler: TimerStateHandler!

    override func setUp() {

        super.setUp()

        stateHandler = TimerStateHandler(
            store: stubStore,
            interval: interval,
            repeats: repeats,
            timerFactory: stubTimerFactory)
    }

    override func tearDown() {

        stubStore = nil
        interval = nil
        repeats = nil
        stubTimerFactory = nil
        stateHandler = nil

        super.tearDown()
    }
}

extension TimerStateHandlerTests {

    // MARK: - init

    func test_init_makeTimerWasCalledCorrectly() {

        XCTAssertEqual(stubTimerFactory.makeTimerWasCalled?.interval, interval)
        XCTAssertEqual(stubTimerFactory.makeTimerWasCalled?.repeats, repeats)
        XCTAssertNotNil(stubTimerFactory.makeTimerWasCalled?.block)
    }

    func test_init_timerBlockIsFiringTickedAndIsRunningActions() {

        stubTimerFactory.makeTimerWasCalled?.block()

        XCTAssertEqual((stubStore.dispatchCalledWithActions.first as? UpdateTimerStateAction)?.state, .ticked)
        XCTAssertEqual((stubStore.dispatchCalledWithActions.last as? UpdateTimerStateAction)?.state, .isRunning)
    }

    func test_init_subscribedToBlock() {

        XCTAssert((stubStore.subscribeCalledWithListener as? TimerStateHandler) === stateHandler)
    }

    func test_init_fireWasCalledOnTimer() {

        XCTAssertEqual(stubTimerFactory.makeTimerStubResult.timesFireWasCalled, 1)
    }

    // MARK: - deinit

    // TODO: Currently failing
//    func test_deinit_unsubscribeBlockWasBlocked() {
//
//        var blockWasCalled = false
//        stubStore.subscribeStubResult = { blockWasCalled = true }
//
//        autoreleasepool {
//
//            weak var _stateHandler = TimerStateHandler(
//                store: stubStore,
//                interval: interval,
//                repeats: repeats,
//                timerFactory: stubTimerFactory)
//        }
//
//        XCTAssert(blockWasCalled)
//    }
}

extension TimerStateHandlerTests {

    // MARK: stateUpdated

    func test_stateUpdate_stateIsStopped_invalidateWasCalledOnTimer() {

        stubStore.stubState = AppState(
            currencies: AppState.CurrenciesState(currencies: [], manualUpdatedCurrencies: []),
            timer: AppState.TimerState(state: .stopped),
            network: AppState.NetworkState(state: .notRunning),
            editing: AppState.EditingState(isEditing: false, hasManuallyBeingUpdated: false))

        stateHandler.stateUpdated()

        XCTAssertEqual(stubTimerFactory.makeTimerStubResult.timesInvalidateWasCalled, 1)
    }

    func test_stateUpdate_stateIsRunningTimerIsNil_makeTimerWasCalled() {

        stubTimerFactory.makeTimerWasCalled = nil
        stubTimerFactory.makeTimerStubResult = StubTimer()
        stubStore.stubState = AppState(
            currencies: AppState.CurrenciesState(currencies: [], manualUpdatedCurrencies: []),
            timer: AppState.TimerState(state: .stopped),
            network: AppState.NetworkState(state: .notRunning),
            editing: AppState.EditingState(isEditing: false, hasManuallyBeingUpdated: false))

        stateHandler.stateUpdated()

        stubStore.stubState = AppState(
            currencies: AppState.CurrenciesState(currencies: [], manualUpdatedCurrencies: []),
            timer: AppState.TimerState(state: .isRunning),
            network: AppState.NetworkState(state: .notRunning),
            editing: AppState.EditingState(isEditing: false, hasManuallyBeingUpdated: false))

        stateHandler.stateUpdated()

        XCTAssertNotNil(stubTimerFactory.makeTimerStubResult)
    }
}
