//
//  RandomJokesPresenter.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

final class RandomJokesPresenterImpl {
    private weak var view: RandomJokesView?
    private let repository: DataRepository

    init(repository: DataRepository) {
        self.repository = repository
    }
}

// MARK: - RandomJokesPresenter

extension RandomJokesPresenterImpl: RandomJokesPresenter {
    func attachView(_ view: RandomJokesView) {
        self.view = view

        fetchData()
    }

    func toggleFavoriteStatus(joke: JokeItem) {
        print("toggleFavoriteStatus")
    }
}

private extension RandomJokesPresenterImpl {
    func fetchData() {
        view?.didStartLoading()

        repository.searchRandomJokes { [weak self] result in
            guard let self else { return }

            defer { self.view?.didFinishLoading() }

            switch result {
            case .success(let jokes):
                let vms = jokes.mapToJokeCellViewModels()
                self.view?.viewModel = RandomJokesViewModel(items: vms)

            case .failure(let error):
                print(error.localizedDescription)
                #warning("handle error")
            }
        }
    }
}

private extension Array where Element == JokeItem {
    func mapToJokeCellViewModels() -> [JokeCell.ViewModel] {
        map {
            JokeCell.ViewModel(joke: $0.joke,
                               pictureURL: $0.iconURL,
                               isFavorite: false,
                               date: $0.updateDate?.toString())
        }
    }
}
