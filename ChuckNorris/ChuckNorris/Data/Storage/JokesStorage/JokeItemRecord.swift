//
//  JokeItemRecord.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/5/23.
//

import Foundation
import GRDB

struct JokeItemRecord: Codable {
    let id: String
    let categories: String
    let value: String
    let iconURL: String?
    let url: String?
    let creationDate: String?
    let updateDate: String?
}

extension JokeItemRecord: TableRecord {
    public static let databaseTableName = "JokeItemRecord"

    /// Mapping between db rows and properties
    enum Columns: String, ColumnExpression {
        case id, categories, value, iconURL, url, creationDate, updateDate
    }
}

extension JokeItemRecord: FetchableRecord, PersistableRecord {
}
