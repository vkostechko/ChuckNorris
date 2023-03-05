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

    private var favoriteJokes: [JokeItem] = []
    private var allJokes: [JokeItem] = []

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

    func toggleFavoriteStatus(jokeId: String) {
        // check is favorite and remove if found
        if let item = favoriteJokes.first(where: { $0.id == jokeId }) {
            removeFromFavorites(joke: item)
            return
        }

        // add to favorites
        if let item = allJokes.first(where: { $0.id == jokeId }) {
            addToFavorites(joke: item)
        }
    }
}

private extension RandomJokesPresenterImpl {
    func fetchData() {
        view?.didStartLoading()

        repository.fetchFavorites { [weak self] result in
            guard let self else { return }

            if case .success(let jokes) = result {
                self.favoriteJokes = jokes
            }

            self.doSearch()
        }
    }

    func doSearch() {
        repository.searchRandomJokes { [weak self] result in
            guard let self else { return }

            defer { self.view?.didFinishLoading() }

            switch result {
            case .success(let jokes):
                self.allJokes = jokes
                self.updateViewModel()

            case .failure(let error):
                print(error.localizedDescription)
                #warning("handle error")
            }
        }
    }

    func removeFromFavorites(joke: JokeItem) {
        repository.removeFromFavorites(jokeId: joke.id) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success:
                self.favoriteJokes.removeAll(where: { $0.id == joke.id })
                self.updateViewModel()

            case .failure(let error):
                #warning("handle error")
                print(error.localizedDescription)
            }
        }
    }

    func addToFavorites(joke: JokeItem) {
        repository.addToFavorites(joke: joke) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success:
                self.favoriteJokes.append(joke)
                self.updateViewModel()

            case .failure(let error):
                #warning("handle error")
                print(error.localizedDescription)
            }
        }
    }

    func updateViewModel() {
        let favoriteIDs = self.favoriteJokes.map { $0.id }
        let vms = allJokes.mapToJokeCellViewModels(favoriteIDs: favoriteIDs)
        view?.viewModel = RandomJokesViewModel(items: vms)
    }
}

private extension Array where Element == JokeItem {
    func mapToJokeCellViewModels(favoriteIDs: [String]) -> [JokeCell.ViewModel] {
        map {
            JokeCell.ViewModel(id: $0.id,
                               joke: $0.joke,
                               pictureURL: $0.iconURL,
                               isFavorite: favoriteIDs.contains($0.id),
                               date: $0.updateDate?.toString())
        }
    }
}
