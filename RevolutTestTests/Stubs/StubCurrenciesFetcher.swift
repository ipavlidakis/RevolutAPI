//
//  StubCurrenciesFetcher.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/17/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

@testable import RevolutTest

final class StubCurrenciesFetcher {

    private(set) var fetchCurrenciesWasCalledWithCompletionBlock: FetcherCompletionBlock?
}

extension StubCurrenciesFetcher: CurrenciesFetching {

    func fetchCurrencies(
        _ completionBlock: @escaping FetcherCompletionBlock) {

        fetchCurrenciesWasCalledWithCompletionBlock = completionBlock
    }
}
