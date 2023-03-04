//
//  RandomJokesViewController.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit

extension RandomJokesViewController {
    struct ViewModel {
        let items: [JokeCell.ViewModel]
    }
}

class RandomJokesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    var viewModel = ViewModel(items: []) {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }

    // MARK: - Private

    private func prepareUI() {
        JokeCell.registerCellNib(in: tableView)
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

