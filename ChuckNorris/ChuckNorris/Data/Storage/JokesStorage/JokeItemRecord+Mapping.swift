//
//  JokeItemRecord+Mapping.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/5/23.
//

import Foundation

extension JokeItemDTO {
    func toRecord() -> JokeItemRecord {
        JokeItemRecord(id: id,
                       categories: categories.joined(separator: ","),
                       value: value,
                       iconURL: iconURL,
                       url: url,
                       creationDate: creationDate,
                       updateDate: updateDate)
    }
}

extension JokeItemRecord {
    func toDTO() -> JokeItemDTO {
        JokeItemDTO(id: id,
                    categories: categories.components(separatedBy: ","),
                    value: value,
                    iconURL: iconURL,
                    url: url,
                    creationDate: creationDate,
                    updateDate: updateDate)
    }
}
