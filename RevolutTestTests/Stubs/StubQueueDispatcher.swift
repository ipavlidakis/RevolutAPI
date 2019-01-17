//
//  StubQueueDispatcher.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

@testable import RevolutTest

final class StubQueueDispatcher {

    private(set) var asyncWasCalledWithBlock: (() -> Void)?
}

extension StubQueueDispatcher: QueueDispatching {

    func async(
        _ block: @escaping () -> Void) {

        asyncWasCalledWithBlock = block
    }
}
