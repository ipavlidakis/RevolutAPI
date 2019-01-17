//
//  ManualUpdateCurrenciesActionTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class ManualUpdateCurrenciesActionTests: XCTestCase {

    // MARK: init

    func test_init_configuredCorrectly() {

        let expected: Double = 10

        let action = ManualUpdateCurrenciesAction(diff: expected)

        XCTAssertEqual(action.diff, expected)
    }
}
