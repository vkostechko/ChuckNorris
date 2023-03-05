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

    func favorite(joke: JokeItemDTO, completion: @escaping AsyncCompletion<Void>)
    func removeFromfavorites(jokeId: String, completion: @escaping AsyncCompletion<Void>)
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
                print("fetch favorite jokes error: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }

    func favorite(joke: JokeItemDTO, completion: @escaping AsyncCompletion<Void>) {
        dbQueue.asyncWrite { db in
            try joke.toRecord().save(db)
        } completion: { _, result in
            switch result {
            case .success:
                DispatchQueue.main.async { completion(.success(())) }

            case .failure(let error):
                print("favorite joke error: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }

    func removeFromfavorites(jokeId: String, completion: @escaping AsyncCompletion<Void>) {
        dbQueue.asyncWrite { db in
            try JokeItemRecord
                .filter(JokeItemRecord.Columns.id == jokeId)
                .deleteAll(db)
        } completion: { _, result in
            switch result {
            case .success:
                DispatchQueue.main.async { completion(.success(())) }

            case .failure(let error):
                print("unfavorite joke error: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
}
