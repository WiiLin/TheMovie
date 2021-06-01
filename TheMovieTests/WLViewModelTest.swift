//
//  WLViewModelTest.swift
//  TheMovieTests
//
//  Created by Wii Lin on 2021/6/2.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

@testable import TheMovie
import XCTest

class WLViewModelTest: XCTestCase {
    let viewModel: WLMovieListViewModel = WLMovieListViewModel(apiCenter: WLFakeApiCenter())
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNeedLoadMore() throws {
        XCTAssertFalse(viewModel.needLoadMore(indexPath: IndexPath(row: 0, section: 0)))
    }
    
    func testLoadingFlag() throws {
        viewModel.loadNextPageData()
        XCTAssertTrue(viewModel.isLoading)
    }
    
    func testResetPage() throws {
        viewModel.resetPage()
        XCTAssertEqual(viewModel.page, 0)
    }
    
    func testPage() throws {
        let apiExpectation = expectation(description: "apiExpectation")
        let page: UInt = 1
        viewModel.loadData(page: page) { [weak self] in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.page, page)
            apiExpectation.fulfill()
        }
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
