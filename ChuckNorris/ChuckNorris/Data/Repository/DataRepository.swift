//
//  DataRepository.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

protocol DataRepository {
    func searchRandomJokes(completion: @escaping AsyncCompletion<[JokeItem]>)
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
    func searchRandomJokes(completion: @escaping AsyncCompletion<[JokeItem]>) {
        network.request(with: API.search(request: SearchRequest(query: "peace"))) { result in
            switch result {
            case .success(let response):
                let jokes = response.jokes.mapToDomain()
                completion(.success(jokes))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
