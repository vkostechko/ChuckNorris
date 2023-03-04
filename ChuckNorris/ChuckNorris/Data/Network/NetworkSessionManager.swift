//
//  NetworkSessionManager.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

protocol NetworkSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    @discardableResult
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> Cancellable
}
