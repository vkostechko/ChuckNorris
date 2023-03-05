//
//  RandomJokesContract.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit

protocol RandomJokesPresenter {
    func attachView(_ view: RandomJokesView)

    func toggleFavoriteStatus(joke: JokeItem)
}

protocol RandomJokesView: UIViewController {
    var presenter: RandomJokesPresenter! { get set }
    var viewModel: RandomJokesViewModel { get set }

    func didStartLoading()
    func didFinishLoading()
}

struct RandomJokesViewModel {
    let items: [JokeCell.ViewModel]
}
