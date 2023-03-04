//
//  JokeCell.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit
import SDWebImage

extension JokeCell {
    struct ViewModel {
        let joke: String
        let pictureURL: URL?
        let date: String?
    }
}

class JokeCell: UITableViewCell {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var jokeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    func update(with viewModel: JokeCell.ViewModel) {
        jokeLabel.text = viewModel.joke
        dateLabel.text = viewModel.date
        pictureImageView.sd_setImage(with: viewModel.pictureURL,
                                     placeholderImage: .placeholder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        pictureImageView.roundCorners()
    }
}
