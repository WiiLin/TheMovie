//
//  WLMovieCell.swift
//  Cathay
//
//  Created by The Movie on 2018/8/9.
//  Copyright © 2018年 The Movie. All rights reserved.
//

import UIKit
import Kingfisher
class WLMovieCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!
    @IBOutlet private var popularityLabel: UILabel!
    @IBOutlet private var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.kf.indicatorType = .activity
        posterImageView.layer.borderColor = UIColor.white.cgColor
        posterImageView.layer.borderWidth = 0.25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.kf.cancelDownloadTask()
    }

    func configure(movie: WLMovie) {
        titleLabel.text = movie.title
        releaseDateLabel.text = "Release date: " + movie.releaseDate
        popularityLabel.text = "Popularity: " + "\(movie.popularity)"

        if let poster_path = movie.posterPath {
            posterImageView.kf.setImage(with: WLMovieImage(imagePath: poster_path).url,
                                       options: [.transition(ImageTransition.fade(0.3)), .forceTransition])
        } else {
            posterImageView.image = nil
        }
    }
}
