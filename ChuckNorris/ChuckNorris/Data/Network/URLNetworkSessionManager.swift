//
//  URLNetworkSessionManager.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

final class URLNetworkSessionManager {
    private let timeoutIntervalForRequest: TimeInterval
    private let timeoutIntervalForResource: TimeInterval
    private let requestCachePolicy: NSURLRequest.CachePolicy

    private var sessionConfiguration: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeoutIntervalForRequest
        config.timeoutIntervalForResource = timeoutIntervalForResource
        config.requestCachePolicy = requestCachePolicy

        return config
    }

    init(timeoutIntervalForRequest: TimeInterval = 30,
         timeoutIntervalForResource: TimeInterval = 30,
         requestCachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy) {
        self.timeoutIntervalForRequest = timeoutIntervalForRequest
        self.timeoutIntervalForResource = timeoutIntervalForResource
        self.requestCachePolicy = requestCachePolicy
    }
}

// MARK: - NetworkSessionManager

extension URLNetworkSessionManager: NetworkSessionManager {
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> Cancellable {
        let session = URLSession(configuration: sessionConfiguration)
        let dataTask = session.dataTask(with: request, completionHandler: completion)
        dataTask.resume()

        return dataTask
    }
}
