//
//  CurrenciesFetcherTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class CurrenciesFetcherTests: XCTestCase {

    private var stubURL: URL! = URL(string: "https://www.revolut.com")!
    private var stubCurrency: String! = "GBP"
    private var stubQueueDispatcher: StubQueueDispatcher! = StubQueueDispatcher()
    private var stubURLSessionFecther: StubURLSessionFetcher! = StubURLSessionFetcher()
    private lazy var request: URLRequest! = URLRequest(url: stubURL)
    private var stubResponse: [String: Any]! = ["rates": ["GBP": Double(10)]]
    private var fetcher: CurrenciesFetcher!

    override func setUp() {

        super.setUp()

        fetcher = CurrenciesFetcher(
            baseURL: stubURL,
            baseCurrency: stubCurrency,
            queueDispatcher: stubQueueDispatcher,
            urlSessionFetcher: stubURLSessionFecther)
    }

    override func tearDown() {

        stubURL = nil
        stubCurrency = nil
        stubQueueDispatcher = nil
        stubURLSessionFecther = nil
        request = nil
        stubResponse = nil
        fetcher = nil

        super.tearDown()
    }
}

extension CurrenciesFetcherTests {

    // MARK: - fetchCurrencies

    func test_fetchCurrencies_fetchWasCalledOnURLSessionFetcherWithCorrectRequest() {

        fetcher.fetchCurrencies { (_, error) in}

        XCTAssertEqual(stubURLSessionFecther.fetchWasCalled?.request.url?.absoluteString, "https://www.revolut.com?base=GBP")
    }

    func test_fetchCurrencies_completesWithError_completionBlockCalledWithError() {

        var blockCalledWithError: Error?
        fetcher.fetchCurrencies { (_, error) in blockCalledWithError = error }

        let error = NSError()
        let expectedResult = Result.error(error)

        stubURLSessionFecther.fetchWasCalled?.completionBlock(expectedResult)

        XCTAssert((blockCalledWithError as! NSError) === error)
    }

    func test_fetchCurrencies_completesSuccessfullyButCannotParsedata_completionBlockCalledWithError() {

        var blockCalledWithError: Error?
        fetcher.fetchCurrencies { (_, error) in blockCalledWithError = error }

        let expectedResult = Result.success([])

        stubURLSessionFecther.fetchWasCalled?.completionBlock(expectedResult)

        guard case FetcherError.unableToParseResponse = blockCalledWithError as! FetcherError else {

            XCTFail("Expected error is FetcherError.unableToParseResponse")
            return
        }

        XCTAssert(true)
    }

    func test_fetchCurrencies_completesSuccessfully_asyncWasCalledOnQueueDispatcher() {

        fetcher.fetchCurrencies { (_, _) in }

        stubURLSessionFecther.fetchWasCalled?.completionBlock(Result.success(stubResponse))

        XCTAssertNotNil(stubQueueDispatcher.asyncWasCalledWithBlock)
    }

    func test_fetchCurrencies_completesSuccessfully_completionBlockCalledWithExpectedData() {

        var blockCalledWithItems: Any?
        fetcher.fetchCurrencies { (items, _) in blockCalledWithItems = items }

        stubURLSessionFecther.fetchWasCalled?.completionBlock(Result.success(stubResponse))
        stubQueueDispatcher.asyncWasCalledWithBlock?()

        XCTAssertEqual(
            (blockCalledWithItems as? [CurrencyPrice])?.first,
            CurrencyPrice(code: "GBP", description: "GBP", price: 10))
    }
}
