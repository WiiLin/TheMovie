//
//  WLMainViewModel.swift
//  TheMovie
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

import Foundation

protocol TMainViewModelDelegate: AnyObject {
    func reloadCompleted()
    func loadMoreCompleted(indexPaths: [IndexPath])
}

class WLMainViewModel {
    init(apiCenter: WLRequestProtocol) {
        self.apiCenter = apiCenter
    }

    // MARK: - Properties
    private let apiCenter: WLRequestProtocol
   
    private(set) var page: UInt = 0
    private(set) var dataSource: [WLMovie] = []
    
    @Observable var sort: WLMovieListApi.Sort = .releaseDate
    @Observable var isLoading: Bool = false
    @Observable var errorMessage: String = ""

    // MARK: - Interface
    weak var delegate: TMainViewModelDelegate? 
    func needLoadMore(indexPath: IndexPath) -> Bool {
        if indexPath.row == dataSource.count - 1 {
            return true
        } else {
            return false
        }
    }

    func loadNextPageData() {
        guard isLoading == false else { return }
        isLoading = true
        loadData(page: page + 1) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
        }
    }
    
    func refreshData() {
        resetPage()
        loadNextPageData()
    }
    
    func resetPage() {
        page = 0
    }

}

// MARK: - Private

private extension WLMainViewModel {
    func loadData(page: UInt,completionHandler:(()->())?) {
        apiCenter.discoverMovies(page: page, sort: sort) {  [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                if page == 1 {
                    self.dataSource.removeAll()
                    self.dataSource = response.results
                    self.delegate?.reloadCompleted()
                } else {
                    let count = self.dataSource.count
                    var indexPath: [IndexPath] = []
                    self.dataSource += response.results
                    for index in count ..< self.dataSource.count {
                        indexPath.append(IndexPath(row: index, section: 0))
                    }
                    self.delegate?.loadMoreCompleted(indexPaths: indexPath)
                }
                self.page = page
            case let .failure(error):
                self.errorMessage = error.description
            }
            completionHandler?()
        }
        
    }
}
