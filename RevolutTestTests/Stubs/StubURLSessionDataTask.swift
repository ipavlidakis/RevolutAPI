//
//  StubURLSessionDataTask.swift
//  RevolutTestTests
//
//  Created by Ilias Pavlidakis on 1/16/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

final class StubURLSessionDataTask: URLSessionDataTask {

    private(set) var resumeWasCalled: Bool?

    override func resume() {

        resumeWasCalled = true
    }
}
