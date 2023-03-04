//
//  Endpoint.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

final class Endpoint<R>: ResponseRequestable {
    public typealias Response = R

    public let path: String
    public let method: HTTPMethodType
    public let queryParametersEncodable: Encodable?
    public let queryParameters: [String: Any]
    public let responseDecoder: ResponseDecoder

    init(path: String,
         method: HTTPMethodType,
         queryParametersEncodable: Encodable? = nil,
         queryParameters: [String: Any] = [:],
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.method = method
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.responseDecoder = responseDecoder
    }
}
