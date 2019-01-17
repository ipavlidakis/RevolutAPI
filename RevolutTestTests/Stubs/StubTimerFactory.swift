//
//  StubTimerFactory.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

@testable import RevolutTest

final class StubTimerFactory {

    var makeTimerWasCalled: (interval: TimeInterval, repeats: Bool, block: () -> Void)?
    var makeTimerStubResult = StubTimer()
}

extension StubTimerFactory: TimerMaking {

    func makeTimer(
        interval: TimeInterval,
        repeats: Bool,
        block: @escaping () -> Void) -> TimerProtocol {

        makeTimerWasCalled = (interval: interval, repeats: repeats, block: block)

        return makeTimerStubResult
    }
}
