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

    var viewModel = RandomJokesViewModel(items: []) {
        didSet {
            tableView.reloadData()
        }
    }

    var presenter: RandomJokesPresenter!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()

        presenter.attachView(self)
    }

    // MARK: - Private

    private func prepareUI() {
        #warning("localize me")
        navigationItem.title = "Chuck greets you!"

        JokeCell.registerCellNib(in: tableView)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
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
