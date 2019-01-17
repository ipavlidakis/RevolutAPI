//
//  JSONURLSession.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

enum Result {

    case success(_ result: Any)
    case error(_ error: Error)
}

enum NetworkError: Int, Error, Equatable {

    case noData
    case jsonParsingError
}

protocol URLSessionFetching {

    func fetch(
        from request: URLRequest,
        completionBlock: @escaping (_ result: Result) -> Swift.Void) -> URLSessionTask
}

final class JSONURLSession {

    let session: URLSession

    init(session: URLSession = .shared) {

        self.session = session
    }
}

extension JSONURLSession: URLSessionFetching {

    func fetch(
        from request: URLRequest,
        completionBlock: @escaping (_ result: Result) -> Swift.Void) -> URLSessionTask {

        let task = session.dataTask(with: request) { (data, response, error) in

            guard let data = data else {

                completionBlock(.error(NetworkError.noData))
                return
            }

            guard let jsonItem = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {

                completionBlock(.error(NetworkError.jsonParsingError))
                return
            }

            completionBlock(.success(jsonItem))
        }

        task.resume()

        return task
    }
}
