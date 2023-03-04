//
//  NetworkConfig.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

protocol NetworkConfigurable {
    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The headers to be used in the request.
    var headers: [String: String] { get }

    /// The query parameters to be used in the request.
    var queryParameters: [String: String] { get }
}

struct NetworkConfig {
    public var baseURL: URL
    public var headers: [String: String] = [:]
    public var queryParameters: [String: String] = [:]
}

extension NetworkConfig: NetworkConfigurable { }
