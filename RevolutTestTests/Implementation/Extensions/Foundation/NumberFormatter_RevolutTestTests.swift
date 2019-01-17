//
//  NumberFormatter_RevolutTestTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class NumberFormatter_RevolutTestTests: XCTestCase {

    // MARK: - projectNumberFormatter

    func test_projectNumberFormatter_isConfiguredCorrectly() {

        let formatter = NumberFormatter.projectNumberFormatter()

        XCTAssertEqual(formatter.numberStyle, .decimal)
        XCTAssertEqual(formatter.maximumFractionDigits, 2)
        XCTAssertEqual(formatter.groupingSeparator, "")
    }
}

