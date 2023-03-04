//
//  NetworkServiceImpl.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

final class NetworkServiceImpl {
    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManager

    init(config: NetworkConfigurable, sessionManager: NetworkSessionManager) {
        self.config = config
        self.sessionManager = sessionManager
    }
}

// MARK: - NetworkService

extension NetworkServiceImpl: NetworkService {
    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> Cancellable? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)

        } catch {
            completion(.failure(.urlGeneration))
            return nil
        }
    }
}

// MARK: - Private

private extension NetworkServiceImpl {
    func request(request: URLRequest,
                 completion: @escaping CompletionHandler) -> Cancellable {
        let sessionDataTask = sessionManager.request(request) { data, response, requestError in
            if let requestError {
                completion(.failure(NetworkError.general(requestError)))
            } else {
                if response?.isValid ?? true {
                    completion(.success(data))
                } else {
                    let error = response?.networkError(with: data) ?? .serverError
                    completion(.failure(error))
                }
            }
        }

        return sessionDataTask
    }
}
