//
//  TimerReducerTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class TimerReducerTests: XCTestCase {

    // MARK: - execute

    func test_execute_actionIsUpdateTimerStateAction_updatesState() {

        let action = UpdateTimerStateAction(state: .ticked)

        let newState = RevolutTest.TimerReducer(AppState.initial, action)

        XCTAssertEqual(newState.timer.state, .ticked)
    }
}
