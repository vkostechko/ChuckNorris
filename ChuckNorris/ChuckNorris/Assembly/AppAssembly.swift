//
//  AppAssembly.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation
import GRDB

final class AppAssembly {
    private(set) lazy var dataRepository: DataRepository = {
        DataRepositoryImpl(network: dataTransferService,
                           storage: JokesStorageImpl(dbQueue: database))
    }()

    private lazy var dataTransferService: DataTransferService = {
        guard let baseURL = URL(string: "https://api.chucknorris.io/jokes/") else {
            fatalError("AppAssembly fatal error: can not initialize base url")
        }

        let config = NetworkConfig(baseURL: baseURL)
        let networkServie = NetworkServiceImpl(config: config,
                                               sessionManager: URLNetworkSessionManager())

        return DataTransferServiceImpl(with: networkServie)
    }()

    private let database: DatabaseQueue

    init() {
        let db = AppDatabase()
        do {
            let queue = try db.openDatabase()
            self.database = queue
        } catch {
            #warning("handle error, show alert or something user friendly")
            print("Init AppDatabse failed: \(error.localizedDescription)")
            fatalError()
        }
    }
}
