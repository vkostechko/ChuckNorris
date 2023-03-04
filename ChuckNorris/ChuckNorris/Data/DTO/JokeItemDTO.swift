//
//  JokeItemDTO.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

struct JokeItemDTO {
    let id: String
    let categories: [String]
    let value: String
    let iconURL: String
    let url: String
    let creationDate: String
    let updateDate: String
}

extension JokeItemDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case categories
        case iconURL = "icon_url"
        case value
        case url
        case creationDate = "created_at"
        case updateDate = "updated_at"
    }
}
