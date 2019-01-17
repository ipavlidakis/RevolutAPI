//
//  StubMiddleware.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

@testable import RevolutTest

final class StubMiddleware: MiddlewareProtocol {

    private(set) var applyWasCalled: (state: AppState, action: ActionProtocol)?

    func apply(
        _ state: AppState,
        _ action: ActionProtocol) {

        applyWasCalled = (state: state, action: action)
    }
}
