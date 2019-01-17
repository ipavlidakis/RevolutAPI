//
//  StubURLSession.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

final class StubURLSession: URLSession {

    private(set) var dataTaskWasCalledWithRequest: URLRequest?
    private(set) var dataTaskWasCalledWithCompletionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var dataTaskWithRequestStubResult = StubURLSessionDataTask()
}

extension StubURLSession {

    override func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        dataTaskWasCalledWithRequest = request
        dataTaskWasCalledWithCompletionHandler = completionHandler
        
        return dataTaskWithRequestStubResult
    }
}
