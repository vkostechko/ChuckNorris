//
//  JokesStorage.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/5/23.
//

import Foundation
import GRDB

protocol JokesStorage {
    func fetchFavoriteJokes(completion: @escaping AsyncCompletion<[JokeItemDTO]>)

    func isJokeFavorite(id: String) -> Bool
    func favorite(joke: JokeItemDTO)
    func unfavorite(joke: JokeItemDTO)
}

final class JokesStorageImpl {
    private let dbQueue: DatabaseQueue

    init(dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
    }
}

// MARK: - JokesStorage

extension JokesStorageImpl: JokesStorage {
    func fetchFavoriteJokes(completion: @escaping AsyncCompletion<[JokeItemDTO]>) {
        dbQueue.asyncRead { dbResult in
            do {
                let db = try dbResult.get()
                let records = try JokeItemRecord.fetchAll(db)
                let jokes = records.map { $0.toDTO() }
                DispatchQueue.main.async {
                    completion(.success(jokes))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func isJokeFavorite(id: String) -> Bool {
        let result = try? dbQueue.read { db in
            do {
                return try JokeItemRecord
                    .filter(JokeItemRecord.Columns.id == id)
                    .isEmpty(db)
            } catch {
                print("isJokeFavorite error: \(error.localizedDescription)")
                return false
            }
        }
        return result ?? false
    }

    func favorite(joke: JokeItemDTO) {
        dbQueue.asyncWrite { db in
            try joke.toRecord().save(db)
        } completion: { _, result in
            if case .failure(let error) = result {
                print("favorite joke error: \(error.localizedDescription)")
            }
        }
    }

    func unfavorite(joke: JokeItemDTO) {
        dbQueue.asyncWrite { db in
            try JokeItemRecord
                .filter(JokeItemRecord.Columns.id == joke.id)
                .deleteAll(db)
        } completion: { _, result in
            if case .failure(let error) = result {
                print("favorite joke error: \(error.localizedDescription)")
            }
        }
    }
}
