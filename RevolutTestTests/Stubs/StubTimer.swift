//
//  StubTimer.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

@testable import RevolutTest

final class StubTimer: TimerProtocol {

    private(set) var timesFireWasCalled: Int = 0

    private(set) var timesInvalidateWasCalled: Int = 0

    func fire() {

        timesFireWasCalled += 1
    }

    func invalidate() {

        timesInvalidateWasCalled += 1
    }
}
