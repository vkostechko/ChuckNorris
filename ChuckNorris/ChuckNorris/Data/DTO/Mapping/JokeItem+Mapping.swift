//
//  JokeItem+Mapping.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

extension JokeItem {
    func toDTO() -> JokeItemDTO {
        JokeItemDTO(id: id,
                    categories: categories,
                    value: joke,
                    iconURL: iconURL?.absoluteString,
                    url: url?.absoluteString,
                    creationDate: creationDate?.toString(),
                    updateDate: updateDate?.toString())
    }
}

extension JokeItemDTO {
    func toDomain() -> JokeItem {
        JokeItem(id: id,
                 categories: categories,
                 joke: value,
                 iconURL: URL(string: iconURL ?? ""),
                 url: URL(string: url ?? ""),
                 creationDate: DateFormatter.serverFormatter.date(from: creationDate ?? ""),
                 updateDate: DateFormatter.serverFormatter.date(from: updateDate ?? ""))
    }
}

extension Array where Element == JokeItemDTO {
    func mapToDomain() -> [JokeItem] {
        map { $0.toDomain() }
    }
}
