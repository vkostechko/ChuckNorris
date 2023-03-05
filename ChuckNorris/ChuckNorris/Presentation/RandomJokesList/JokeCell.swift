//
//  JokeCell.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit
import SDWebImage

extension JokeCell {
    struct ViewModel: Equatable {
        let id: String
        let joke: String
        let pictureURL: URL?
        let isFavorite: Bool
        let date: String?

        var favoriteIcon: UIImage? {
            let name = isFavorite ? "icStarGold" : "icStarWhite"
            return UIImage(named: name)
        }
    }
}

protocol JokeCellDelegate: AnyObject {
    func jokeCell(_ cell: JokeCell, didTapFavoriteButton: UIButton)
}

class JokeCell: UITableViewCell {
    @IBOutlet private var pictureImageView: UIImageView!
    @IBOutlet private var jokeLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var favoriteButton: UIButton!

    weak var delegate: JokeCellDelegate?

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        let bckView = UIView()
        bckView.backgroundColor = UIColor.cnGold.withAlphaComponent(0.3)
        self.selectedBackgroundView = bckView
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        pictureImageView.roundCorners()
    }

    // MARK: - Actions

    @IBAction private func favoriteButtonDidTap(_ sender: Any) {
        delegate?.jokeCell(self, didTapFavoriteButton: favoriteButton)
    }

    // MARK: - Public

    func update(with viewModel: JokeCell.ViewModel) {
        jokeLabel.text = viewModel.joke
        dateLabel.text = viewModel.date

        favoriteButton.setImage(viewModel.favoriteIcon, for: .normal)

        pictureImageView.sd_setImage(with: viewModel.pictureURL,
                                     placeholderImage: .placeholder)
    }
}
