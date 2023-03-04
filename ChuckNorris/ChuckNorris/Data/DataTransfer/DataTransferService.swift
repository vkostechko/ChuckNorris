//
//  DataTransferService.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void

    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                       completion: @escaping CompletionHandler<T>) -> Cancellable? where E.Response == T
}

final class DataTransferServiceImpl {
    private let networkService: NetworkService

    init(with networkService: NetworkService) {
        self.networkService = networkService
    }
}

// MARK: - DataTransferService

extension DataTransferServiceImpl: DataTransferService {
    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E,
                                                       completion: @escaping CompletionHandler<T>) -> Cancellable? where E.Response == T {
        networkService.request(endpoint: endpoint) { [weak self] responseResult in
            guard let self = self else { return }
            switch responseResult {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data,
                                                                       decoder: endpoint.responseDecoder)
                DispatchQueue.main.async { completion(result) }

            case .failure(let networkError):
                DispatchQueue.main.async {
                    completion(.failure(.networkFailure(networkError)))
                }
            }
        }
    }
}

// MARK: - Private

private extension DataTransferServiceImpl {
    private func decode<T: Decodable>(data: Data?,
                                      decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        guard let data else {
            return .failure(.noResponse)
        }

        do {
            let result: T = try decoder.decode(data)
            return .success(result)

        } catch {
            return .failure(.parsing(error))
        }
    }
}
