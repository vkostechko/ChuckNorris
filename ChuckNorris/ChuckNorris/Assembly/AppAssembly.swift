//
//  AppAssembly.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

final class AppAssembly {
    let networkServie: NetworkService

    init() {
        guard let baseURL = URL(string: "https://api.chucknorris.io/") else {
            fatalError("AppAssembly fatal error: can not initialize base url")
        }

        let config = NetworkConfig(baseURL: baseURL)
        self.networkServie = NetworkServiceImpl(config: config,
                                                sessionManager: URLNetworkSessionManager())
    }
}
