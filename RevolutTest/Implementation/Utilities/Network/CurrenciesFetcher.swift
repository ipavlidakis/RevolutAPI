//
//  CurrenciesFetcher.swift
//  RevolutTest
//
//  Created by Ilias Pavlidakis on 1/15/19.
//  Copyright © 2019 Ilias Pavlidakis. All rights reserved.
//

import Foundation

enum FetcherError: Error {

    case unableToCreateRequest
    case unableToParseResponse
}

typealias FetcherCompletionBlock = (_ items: [CurrencyPrice], _ error: Error?) -> Swift.Void

protocol CurrenciesFetching {

    func fetchCurrencies(
        _ completionBlock: @escaping FetcherCompletionBlock)
}

final class CurrenciesFetcher {

    private let baseURL: URL
    private let baseCurrency: String
    private let queueDispatcher: QueueDispatching
    private let urlSessionFetcher: URLSessionFetching

    private var lastTask: URLSessionTask?

    init(baseURL: URL = URL(string: "https://revolut.duckdns.org/latest")!,
         baseCurrency: String = "EUR",
         queueDispatcher: QueueDispatching = MainQueueDispatcher(),
         urlSessionFetcher: URLSessionFetching = JSONURLSession()) {

        self.baseURL = baseURL
        self.baseCurrency = baseCurrency
        self.queueDispatcher = queueDispatcher
        self.urlSessionFetcher = urlSessionFetcher
    }
}

private extension CurrenciesFetcher {

    func makeRequest(
        url: URL,
        httpMethod: String = "GET",
        queryItems: [String: String?],
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        timeoutInterval: TimeInterval = 30) -> URLRequest? {

        guard
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {

                return nil
        }

        urlComponents.queryItems = queryItems
            .map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let constructedURL = urlComponents.url else {

            return nil
        }

        var request = URLRequest(
            url: constructedURL,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval)

        request.httpMethod = httpMethod

        return request
    }

    func parse(
        responseData: Any) -> [CurrencyPrice]? {

        guard
            let responseDictionary = responseData as? [String: Any],
            let rates = responseDictionary["rates"] as? [String: Double] else {

            return nil;
        }

        return rates.map { CurrencyPrice(code: $0.key, description: $0.key, price: $0.value) }
    }
}

extension CurrenciesFetcher: CurrenciesFetching {

    func fetchCurrencies(
        _ completionBlock: @escaping FetcherCompletionBlock) {

        if let currentTask = lastTask,
            currentTask.state == .running {

            currentTask.cancel()
        }

        guard let request = makeRequest(url: baseURL, queryItems: ["base": baseCurrency]) else {

            completionBlock([], FetcherError.unableToCreateRequest)
            return
        }

        lastTask = urlSessionFetcher.fetch(from: request) { [weak self] (response) in

            guard let self = `self` else { return }

            switch response {

            case .success(let result):

                guard let items = self.parse(responseData: result) else {

                    completionBlock([], FetcherError.unableToParseResponse)
                    return
                }

                self.queueDispatcher.async {

                    completionBlock(items, nil)
                }
            case .error(let error):

                completionBlock([], error)
            }
        }
    }
}
