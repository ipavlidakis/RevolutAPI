//
//  JSONURLSessionTests.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation
import XCTest

@testable import RevolutTest

final class JSONURLSessionTests: XCTestCase {

    private var stubSession: StubURLSession! = StubURLSession()
    private var request: URLRequest! = URLRequest(url: URL(string: "https://www.revolut.com")!)
    private lazy var jsonURLSession: JSONURLSession! = JSONURLSession(session: stubSession)

    override func tearDown() {

        stubSession = nil
        request = nil
        jsonURLSession = nil

        super.tearDown()
    }
}

extension JSONURLSessionTests {

    // MARK: fetch

    func test_fetch_dataTaskWithRequestInvokedWithCorrectRequest() {

        _ = jsonURLSession.fetch(
            from: request,
            completionBlock: { _ in })

        XCTAssertEqual(stubSession.dataTaskWasCalledWithRequest, request)
    }

    func test_fetch_resumeWasCalledOnReturnDataTask() {

        let result = jsonURLSession.fetch(
            from: request,
            completionBlock: { _ in })

        XCTAssert((result as? StubURLSessionDataTask)?.resumeWasCalled ?? false)
    }

    func test_fetch_returnsExpectedValue() {

        let result = jsonURLSession.fetch(
            from: request,
            completionBlock: { _ in })

        XCTAssertEqual(result, stubSession.dataTaskWithRequestStubResult)
    }

    func test_fetch_noData_completionBlockWasCalledWithNoDataError() {


    }

    func test_fetch_noJsonDictionaryData_completionBlockWasCalledWithJsonParsingError() {

    }

    func test_fetch_completionBlockWasCalledWithExpectedDictionary() {

        var result: Any?
        _ = jsonURLSession.fetch(
            from: request,
            completionBlock: { _result in

                switch _result {

                case .success(let value):
                    result = value
                default:
                    break
                }
        })

        let object = ["name": "Revolut"]
        let data = try! JSONSerialization.data(
            withJSONObject: object,
            options: .prettyPrinted)

        stubSession.dataTaskWasCalledWithCompletionHandler?(data, nil, nil)

        XCTAssertEqual(result as? Dictionary, object)
    }
}
