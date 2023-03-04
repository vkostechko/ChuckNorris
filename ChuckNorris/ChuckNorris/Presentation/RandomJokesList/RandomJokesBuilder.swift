//
//  RandomJokesBuilder.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

struct RandomJokesBuilder {
    let dataRepository: DataRepository

    init(dataRepository: DataRepository) {
        self.dataRepository = dataRepository
    }

    func configure() -> RandomJokesView {
        let view = AppFlow.ramdomJokesView()
        view.presenter = RandomJokesPresenterImpl(repository: dataRepository)
        return view
    }
}
