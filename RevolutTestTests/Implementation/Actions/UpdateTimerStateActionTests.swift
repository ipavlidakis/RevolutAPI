//
//  UpdateTimerStateActionTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class UpdateTimerStateActionTests: XCTestCase {

    // MARK: init

    func test_init_configuredCorrectly() {

        let expected = AppState.TimerState.State.stopped

        let action = UpdateTimerStateAction(state: expected)

        XCTAssertEqual(action.state, expected)
    }
}
