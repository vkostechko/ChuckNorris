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
    private var mode: SourceMode = .defaultMode

    private var lastSearchTerm: String?
    private var searchOperation: Cancellable?

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

    func search(term: String) {
        guard lastSearchTerm != term else { return }
        guard !term.isEmpty else {
            allJokes = favoriteJokes
            updateViewModel()
            return
        }
        guard term.count >= 3 && term.count <= 120 else {
            return
        }

        lastSearchTerm = term
        doSearch(term: term)
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

    func toggleSourceMode() {
        mode.toggle()
        updateViewModel()
    }
}

private extension RandomJokesPresenterImpl {
    func fetchData() {
        view?.didStartLoading()

        repository.fetchFavorites { [weak self] result in
            guard let self else { return }

            if case .success(let jokes) = result {
                self.favoriteJokes = jokes
                self.allJokes = jokes
                self.updateViewModel()
            }

            self.view?.didFinishLoading()
        }
    }

    func doSearch(term: String) {
        searchOperation?.cancel()

        view?.didStartLoading()

        searchOperation = repository.search(term: term) { [weak self] result in
            guard let self else { return }

            defer { self.view?.didFinishLoading() }

            switch result {
            case .success(let jokes):
                self.allJokes = jokes

            case .failure(let error):
                print(error.localizedDescription)
                #warning("handle error")
                self.allJokes = []
            }

            self.updateViewModel()
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
        let favoriteIDs = favoriteJokes.map { $0.id }
        let vms: [JokeCell.ViewModel]

        switch mode {
        case .all:
            vms = allJokes.mapToJokeCellViewModels(favoriteIDs: favoriteIDs)

        case .favorite:
            vms = favoriteJokes.mapToJokeCellViewModels(favoriteIDs: favoriteIDs)
        }
        
        view?.viewModel = RandomJokesViewModel(mode: mode, items: vms)
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
