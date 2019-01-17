//
//  NetworkReducerTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class NetworkReducerTests: XCTestCase {

    // MARK: - execute

    func test_execute_actionIsUpdateNetworkStateActionAction_updatesState() {

        let action = UpdateNetworkStateAction(state: .isRunning)

        let newState = RevolutTest.NetworkReducer(AppState.initial, action)

        XCTAssertEqual(newState.network.state, .isRunning)
    }
}
