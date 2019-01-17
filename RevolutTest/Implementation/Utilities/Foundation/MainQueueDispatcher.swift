//
//  MainQueueDispatcher.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

protocol QueueDispatching {

    func async(
        _ block: @escaping () -> Swift.Void)
}

final class MainQueueDispatcher {

    private let queue: DispatchQueue

    init(queue: DispatchQueue = DispatchQueue.main) {

        self.queue = queue
    }
}

extension MainQueueDispatcher: QueueDispatching {

    func async(
        _ block: @escaping () -> Swift.Void) {

        queue.async(execute: block)
    }
}
