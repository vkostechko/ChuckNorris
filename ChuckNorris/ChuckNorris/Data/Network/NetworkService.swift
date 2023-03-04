//
//  NetworkService.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

enum NetworkError: Error {
    case urlGeneration
    case serverError
    case error(statusCode: Int, data: Data?)
    case general(Error)
}

protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void

    @discardableResult
    func request(endpoint: Requestable,
                 completion: @escaping CompletionHandler) -> Cancellable?
}
