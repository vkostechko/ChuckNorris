//
//  DataTransferError.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
    case common
}

extension DataTransferError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noResponse, .common:
            #warning("localize me")
            return "Something went wrong. Please, try again"

        case .parsing(let error):
            return error.localizedDescription

        case .networkFailure(let error):
            return error.localizedDescription

        case .resolvedNetworkFailure(let error):
            return error.localizedDescription
        }
    }
}
