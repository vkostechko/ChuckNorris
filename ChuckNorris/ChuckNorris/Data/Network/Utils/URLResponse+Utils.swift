//
//  URLResponse+Utils.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

extension URLResponse {
    var isValid: Bool {
        guard let statusCode = (self as? HTTPURLResponse)?.statusCode else { return true }

        switch statusCode {
        case 200...399:
            return true

        default:
            return false
        }
    }

    func networkError(with data: Data?) -> NetworkError? {
        guard let statusCode = (self as? HTTPURLResponse)?.statusCode else { return nil }
        return .error(statusCode: statusCode, data: data)
    }
}
