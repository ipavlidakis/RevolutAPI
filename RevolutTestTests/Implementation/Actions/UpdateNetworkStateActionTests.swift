//
//  UpdateNetworkStateActionTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class UpdateNetworkStateActionTests: XCTestCase {

    // MARK: init

    func test_init_configuredCorrectly() {

        let expected = AppState.NetworkState.State.isRunning

        let action = UpdateNetworkStateAction(state: expected)

        XCTAssertEqual(action.state, expected)
    }
}
