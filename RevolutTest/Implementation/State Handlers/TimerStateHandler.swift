//
//  TimerStateHandler.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

final class TimerStateHandler {

    let identifier: UUID = UUID()

    private let store: StoreProtocol
    private let interval: TimeInterval
    private let repeats: Bool
    private let timerFactory: TimerMaking

    private var timer: TimerProtocol?
    private var unsubscribeBlock: UnsubscribeListener?

    init(store: StoreProtocol,
         interval: TimeInterval,
         repeats: Bool = true,
         timerFactory: TimerMaking) {

        self.store = store
        self.interval = interval
        self.repeats = repeats
        self.timerFactory = timerFactory

        self.timer = timerFactory.makeTimer(
            interval: interval,
            repeats: repeats,
            block: execute)

        self.unsubscribeBlock = store.subscribe(self)

        self.timer?.fire()
    }

    deinit {

        unsubscribeBlock?()
    }
}

extension TimerStateHandler {

    func execute() {

        store.dispatch(UpdateTimerStateAction(state: .ticked))
        store.dispatch(UpdateTimerStateAction(state: .isRunning))
    }
}

extension TimerStateHandler: ListenerProtocol {

    func stateUpdated() {

        switch store.state.timer.state {
        case .stopped:

            timer?.invalidate()
            timer = nil
        case .isRunning:

            guard timer == nil else { return }
            timer = timerFactory.makeTimer(
                interval: interval,
                repeats: repeats,
                block: execute)

        default: break
        }
    }
}
