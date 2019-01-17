//
//  StubURLSessionFetcher.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

@testable import RevolutTest

final class StubURLSessionFetcher {

    private(set) var fetchWasCalled: (request: URLRequest, completionBlock: (Result) -> Void)?
    var fetchStubResult: StubURLSessionDataTask = StubURLSessionDataTask()
}

extension StubURLSessionFetcher: URLSessionFetching {

    func fetch(
        from request: URLRequest,
        completionBlock: @escaping (Result) -> Void) -> URLSessionTask {

        fetchWasCalled = (request: request, completionBlock: completionBlock)

        return fetchStubResult
    }
}
