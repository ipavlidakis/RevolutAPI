//
//  UpdateEditingActionTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class UpdateEditingActionTests: XCTestCase {

    // MARK: init

    func test_init_configuredCorrectly() {

        let expectedIsEditing = false
        let expectedHasManuallyBeingUpdated = false

        let action = UpdateEditingAction(
            isEditing: expectedIsEditing,
            hasManuallyBeingUpdated: expectedHasManuallyBeingUpdated)

        XCTAssertEqual(action.isEditing, expectedIsEditing)
        XCTAssertEqual(action.hasManuallyBeingUpdated, expectedHasManuallyBeingUpdated)
    }
}
