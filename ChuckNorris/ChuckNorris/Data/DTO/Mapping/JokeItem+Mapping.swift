//
//  JokeItem+Mapping.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

extension JokeItemDTO {
    func toDomain() -> JokeItem {
        JokeItem(id: id,
                 categories: categories,
                 joke: value,
                 iconURL: URL(string: iconURL),
                 url: URL(string: url),
                 creationDate: DateFormatter.defaultFormatter.date(from: creationDate),
                 updateDate: DateFormatter.defaultFormatter.date(from: updateDate))
    }
}

extension Array where Element == JokeItemDTO {
    func mapToDomain() -> [JokeItem] {
        map { $0.toDomain() }
    }
}
