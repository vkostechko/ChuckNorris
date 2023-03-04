//
//  Joke.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

struct JokeItem {
    let id: String
    let categories: [String]
    let joke: String
    let iconURL: URL?
    let url: URL?
    let creationDate: Date?
    let updateDate: Date?
}
