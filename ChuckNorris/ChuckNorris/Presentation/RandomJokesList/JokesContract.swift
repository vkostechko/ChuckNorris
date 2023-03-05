//
//  JokesContract.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit

protocol JokesPresenter {
    func attachView(_ view: JokesView)

    func search(term: String)
    func toggleFavoriteStatus(jokeId: String)
    func toggleSourceMode()
}

protocol JokesView: UIViewController {
    var presenter: JokesPresenter! { get set }
    var viewModel: RandomJokesViewModel { get set }

    func didStartLoading()
    func didFinishLoading()
}

struct RandomJokesViewModel: Equatable {
    let mode: SourceMode
    let items: [JokeCell.ViewModel]
}

enum SourceMode: Equatable {
    case all
    case favorite

    static let defaultMode = SourceMode.all

    var icon: UIImage? {
        switch self {
        case .all:
            return UIImage(named: "icStarWhite")?.withRenderingMode(.alwaysOriginal)

        case .favorite:
            return UIImage(named: "icStarGold")?.withRenderingMode(.alwaysOriginal)
        }
    }

    mutating func toggle() {
        switch self {
        case .all:
            self = .favorite

        case .favorite:
            self = .all
        }
    }
}
