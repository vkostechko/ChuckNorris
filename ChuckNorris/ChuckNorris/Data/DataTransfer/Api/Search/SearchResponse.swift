//
//  SearchResponse.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

struct SearchResponse: Decodable {
    let jokes: [JokeItemDTO]

    enum CodingKeys: String, CodingKey {
        case jokes = "result"
    }
}
