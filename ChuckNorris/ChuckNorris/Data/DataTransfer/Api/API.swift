//
//  JokesApi.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

enum API {
    private static let searchPath = "search"

    static func search(request: SearchRequest) -> Endpoint<SearchResponse> {
        Endpoint(path: searchPath,
                 method: .get,
                 queryParametersEncodable: request)
    }

}
