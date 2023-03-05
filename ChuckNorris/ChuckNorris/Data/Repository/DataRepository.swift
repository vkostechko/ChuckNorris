//
//  DataRepository.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

protocol DataRepository {
    func fetchFavorites(completion: @escaping AsyncCompletion<[JokeItem]>)

    @discardableResult
    func search(term: String,
                completion: @escaping AsyncCompletion<[JokeItem]>) -> Cancellable?

    func removeFromFavorites(jokeId: String, completion: @escaping AsyncCompletion<Void>)
    func addToFavorites(joke: JokeItem, completion: @escaping AsyncCompletion<Void>)
}

final class DataRepositoryImpl {
    let network: DataTransferService
    let storage: JokesStorage

    init(network: DataTransferService, storage: JokesStorage) {
        self.network = network
        self.storage = storage
    }
}

// MARK: - DataRepository

extension DataRepositoryImpl: DataRepository {
    func fetchFavorites(completion: @escaping AsyncCompletion<[JokeItem]>) {
        storage.fetchFavoriteJokes { result in
            switch result {
            case .success(let jokesDTO):
                let jokes = jokesDTO.mapToDomain()
                completion(.success(jokes))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    @discardableResult
    func search(term: String,
                completion: @escaping AsyncCompletion<[JokeItem]>) -> Cancellable? {
        network.request(with: API.search(request: SearchRequest(query: term))) { result in
            switch result {
            case .success(let response):
                let jokes = response.jokes.mapToDomain()
                completion(.success(jokes))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func removeFromFavorites(jokeId: String, completion: @escaping AsyncCompletion<Void>) {
        storage.removeFromfavorites(jokeId: jokeId, completion: completion)
    }

    func addToFavorites(joke: JokeItem, completion: @escaping AsyncCompletion<Void>) {
        storage.favorite(joke: joke.toDTO(), completion: completion)
    }
}
