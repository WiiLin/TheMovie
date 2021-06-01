//
//  WLMainViewController.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import UIKit
import PKHUD
class WLMainViewController: UIViewController,AlertPresentable {
    @IBOutlet private var tableView: UITableView!
    private var refreshControl: UIRefreshControl!
    private let viewModel: WLMainViewModel = WLMainViewModel(apiCenter: WLApiCenter())

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        initBinding()
    }

}

// MARK: - Private Method

private extension WLMainViewController {
    func setupSubviews() {
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        tableView.register(UINib(nibName: "\(WLMovieCell.self)", bundle: nil), forCellReuseIdentifier: "\(WLMovieCell.self)")
        setupRefreshControl()
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(WLMainViewController.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .lightGreen
        tableView.refreshControl = refreshControl
    }
    
    func initBinding() {
        viewModel.delegate = self
        viewModel.$errorMessage(bind: self) { weakSelf, errorMessage in
            weakSelf.presentErrorAlert(message: errorMessage, action: nil)
        }
        
        viewModel.$isLoading(bind: self) { weakSelf, isLoading in
            if isLoading {
                HUD.show(.progress, onView: weakSelf.view)
            } else {
                weakSelf.refreshControl.endRefreshing()
                HUD.hide()
            }
        }
    }
}

// MARK: - Private Action

private extension WLMainViewController {
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.refreshData()
    }
}

// MARK: - TableView Delegate

extension WLMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.needLoadMore(indexPath: indexPath) {
            viewModel.loadNextPageData()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let movieDetailVC = WLMovieDetailViewController.movieDetailViewController(movie: viewModel.dataSource[indexPath.row])
//        present(movieDetailVC, animated: true, completion: nil)
    }
}

// MARK: - TableView Delegate

extension WLMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(WLMovieCell.self)", for: indexPath) as! WLMovieCell
        cell.configure(movie: viewModel.dataSource[indexPath.row])
        return cell
    }
}

// MARK: - TableView Delegate

extension WLMainViewController: TMainViewModelDelegate {
    func reloadCompleted() {
        tableView.reloadData()
    }
    func loadMoreCompleted(indexPaths: [IndexPath]) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()
    }
}
