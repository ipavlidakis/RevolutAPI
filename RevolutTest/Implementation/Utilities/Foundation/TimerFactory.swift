//
//  TimerFactory.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

protocol TimerMaking {

    func makeTimer(
        interval: TimeInterval,
        repeats: Bool,
        block: @escaping () -> Void) -> TimerProtocol
}

struct TimerFactory: TimerMaking {

    func makeTimer(
        interval: TimeInterval,
        repeats: Bool,
        block: @escaping () -> Void) -> TimerProtocol {

        return Timer.scheduledTimer(
            withTimeInterval: interval,
            repeats: repeats,
            block: { _ in block() })
    }
}
