//
//  WLMovieDetailViewController.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Kingfisher
import SafariServices
import UIKit
class WLMovieDetailViewController: UIViewController {
    // MARK: - IBOutlet
    
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var backdropImageView: UIImageView!
    @IBOutlet private var contentView: UIView!
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var overviewLabel: UILabel!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var genreLabel: UILabel!
    @IBOutlet private var runTimeLabel: UILabel!
    
    // MARK: - Properties
    
    let detail: WLMovieDetail
    let movie: WLMovie
    
    // MARK: - Init
    
    class func controller(movie: WLMovie, detail: WLMovieDetail) -> WLMovieDetailViewController {
        let vc: WLMovieDetailViewController = WLMovieDetailViewController(movie: movie, detail: detail)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
    
    init(movie: WLMovie, detail: WLMovieDetail) {
        self.movie = movie
        self.detail = detail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBaseUI(movie: movie)
        configureDetailUI(movieDetail: detail)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        posterImageView.kf.cancelDownloadTask()
        backdropImageView.kf.cancelDownloadTask()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Private Method

private extension WLMovieDetailViewController {
    private func configureBaseUI(movie: WLMovie) {
        titleLabel.text = movie.title
        if let posterPath = movie.posterPath {
            posterImageView.kf.setImage(with: WLMovieImage(imagePath: posterPath).url,
                                        options: [.transition(ImageTransition.fade(0.3)), .forceTransition])
        } else {
            posterImageView.image = nil
        }
        if let backdropPath = movie.backdropPath {
            backdropImageView.kf.setImage(with: WLMovieImage(imagePath: backdropPath).url,
                                          options: [.transition(ImageTransition.fade(0.3)), .forceTransition])
        } else {
            backdropImageView.image = nil
        }
    }
    
    private func configureDetailUI(movieDetail: WLMovieDetail) {
        genreLabel.text = movieDetail.displayGenres
        languageLabel.text = movieDetail.displaySpokenLanguages
        if let runtime = movieDetail.runtime {
            runTimeLabel.text = "\(runtime) mins"
        } else {
            runTimeLabel.text = nil
        }
        overviewLabel.text = movieDetail.overview
    }
}

// MARK: - Private Actions

private extension WLMovieDetailViewController {
    @IBAction func onClickCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickMore(_ sender: Any) {
        guard let url = URL(string: "https://www.themoviedb.org/movie/\(movie.id)") else { return }
        let vc = SFSafariViewController(url: url, configuration: SFSafariViewController.Configuration())
        present(vc, animated: true)
    }
}
