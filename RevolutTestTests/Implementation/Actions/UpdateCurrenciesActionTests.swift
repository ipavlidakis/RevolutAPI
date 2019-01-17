//
//  UpdateCurrenciesActionTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class UpdateCurrenciesActionTests: XCTestCase {

    // MARK: init

    func test_init_configuredCorrectly() {

        let items = [CurrencyPrice(code: "Code", description: "Code", price: 10)]

        let action = UpdateCurrenciesAction(newCurrencies: items)

        XCTAssertEqual(action.newCurrencies, items)
    }
}
