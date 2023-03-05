//
//  RandomJokesViewController.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit

class RandomJokesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var modeButton: UIBarButtonItem!

    var viewModel = RandomJokesViewModel(mode: .defaultMode, items: []) {
        didSet {
            if oldValue != viewModel {
                updateUI()
            }
        }
    }

    var presenter: RandomJokesPresenter!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()

        presenter.attachView(self)
    }

    // MARK: - Actions

    @IBAction private func modeButtonDidTap(_ sender: Any) {
        presenter.toggleSourceMode()
    }

    // MARK: - Private

    private func prepareUI() {
        #warning("localize me")
        navigationItem.title = "Chuck greets you!"

        modeButton.image = viewModel.mode.icon

        JokeCell.registerCellNib(in: tableView)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
    }

    private func updateUI() {
        tableView.reloadData()
        modeButton.image = viewModel.mode.icon
    }
}

// MARK: - UITableViewDataSource

extension RandomJokesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: JokeCell.reuseIdentifier,
                                                     for: indexPath) as? JokeCell
        else {
            fatalError("can not initialize cell at index path: \(indexPath)")
        }
        cell.update(with: viewModel.items[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: - RandomJokesView

extension RandomJokesViewController: RandomJokesView {
    func didStartLoading() {
        loadingIndicatorView.startAnimating()
    }

    func didFinishLoading() {
        loadingIndicatorView.stopAnimating()
    }
}

// MARK: - JokeCellDelegate

extension RandomJokesViewController: JokeCellDelegate {
    func jokeCell(_ cell: JokeCell, didTapFavoriteButton: UIButton) {
        guard let ip = tableView.indexPath(for: cell) else { return }

        let joke = viewModel.items[ip.row]
        presenter.toggleFavoriteStatus(jokeId: joke.id)
    }
}
