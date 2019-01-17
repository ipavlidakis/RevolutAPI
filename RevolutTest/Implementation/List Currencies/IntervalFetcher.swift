//
//  IntervalFetcher.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

protocol IntervalFetching {

    func pause()

    func resume()
}

final class IntervalFetcher {

    private let interval: TimeInterval
    private let timerFactory: TimerMaking
    private let fetcher: CurrenciesFetching
    private let refreshBlock: FetcherCompletionBlock

    private var timer: Timer?

    init(interval: TimeInterval,
         fetcher: CurrenciesFetching,
         timerFactory: TimerMaking,
         refreshBlock: @escaping FetcherCompletionBlock) {

        self.interval = interval
        self.fetcher = fetcher
        self.timerFactory = timerFactory
        self.refreshBlock = refreshBlock

        self.timer = timerFactory.makeTimer(
            interval: interval,
            repeats: true,
            block: self.execute)

        self.timer?.fire()
    }

}

extension IntervalFetcher {

    func execute() {

        print("Will execute")

        fetcher.fetchCurrencies(refreshBlock)
    }
}

extension IntervalFetcher: IntervalFetching {

    func pause() {

        timer?.invalidate()
    }

    func resume() {

        timer = timerFactory.makeTimer(
            interval: interval,
            repeats: true,
            block: execute)
    }
}
