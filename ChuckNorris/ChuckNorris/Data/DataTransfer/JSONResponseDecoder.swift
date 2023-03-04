//
//  JSONResponseDecoder.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

final class JSONResponseDecoder {
    private lazy var jsonDecoder: JSONDecoder = { JSONDecoder() }()
}

// MARK: - ResponseDecoder

extension JSONResponseDecoder: ResponseDecoder {
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
