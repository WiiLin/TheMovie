//
//  WLMovieListViewController.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import UIKit
import PKHUD
class WLMovieListViewController: UIViewController,AlertPresentable {
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

private extension WLMovieListViewController {
    func setupSubviews() {
        title = "Movie List"
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        tableView.register(UINib(nibName: "\(WLMovieCell.self)", bundle: nil), forCellReuseIdentifier: "\(WLMovieCell.self)")
        setupRefreshControl()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(onClickSort))
    }
    
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(WLMovieListViewController.handleRefresh(_:)), for: .valueChanged)
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
        viewModel.$sort(bind: self, fireNow: true) { weakSelf, sort in
            weakSelf.navigationItem.prompt = "Sort by \(sort.displayName)"
            weakSelf.viewModel.refreshData()
        }
    }
}

// MARK: - Private Action

private extension WLMovieListViewController {
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.refreshData()
    }
    @objc func onClickSort() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let source = WLMovieListApi.Sort.allCases
        for (index, sortBy) in source.enumerated() {
            let action = UIAlertAction(title: sortBy.displayName, style: .default) { [weak self] action in
                guard let self = self else { return }
                self.viewModel.sort = source[index]
            }
            actionSheet.addAction(action)
        }
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - TableView Delegate

extension WLMovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.needLoadMore(indexPath: indexPath) {
            viewModel.loadNextPageData()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.showMovieDetail(indexPath: indexPath, vc: self)
    }
    
}

// MARK: - TableView Delegate

extension WLMovieListViewController: UITableViewDataSource {
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

extension WLMovieListViewController: TMainViewModelDelegate {
    func reloadCompleted() {
        tableView.reloadData()
    }
    func loadMoreCompleted(indexPaths: [IndexPath]) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()
    }
}
