//
//  WLApiTest.swift
//  TheMovieTests
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

@testable import TheMovie
import XCTest

class WLApiTest: XCTestCase {
    let apiVersion: String = "3"
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testApiKey() throws {
        XCTAssertEqual(WLApiBase().apiKey, "328c283cd27bd1877d9080ccb1604c91")
    }
    
    func testApiVersion() throws {
        XCTAssertEqual(WLApiPath.movieList.version, apiVersion)
        XCTAssertEqual(WLApiPath.movieDetail.version, apiVersion)
    }
    
    func testApi() throws {
        let testApiKey = "testApiKey"
        let testPrimaryReleaseDatelte = "2020-06-01"
        let testSortBy: WLMovieListApi.Sort = .popularity
        let testPage: UInt = 0
        let movieListApi = WLMovieListApi(apiKey: testApiKey, primaryReleaseDatelte: testPrimaryReleaseDatelte, sortBy: testSortBy, page: testPage)
        
        XCTAssertEqual(movieListApi.apiKey, testApiKey)
        XCTAssertEqual(movieListApi.primaryReleaseDatelte, testPrimaryReleaseDatelte)
        XCTAssertEqual(movieListApi.sortBy, testSortBy)
        XCTAssertEqual(movieListApi.page, testPage)
        XCTAssertEqual(movieListApi.method, .get)
        XCTAssertEqual(movieListApi.path, "/\(apiVersion)/discover/movie")
        
        let testId: Int = 0
        let movieDetailApi = WLMovieDetailApi(id: testId, apiKey: testApiKey)
        XCTAssertEqual(movieDetailApi.id, testId)
        XCTAssertEqual(movieDetailApi.apiKey, testApiKey)
        XCTAssertEqual(movieDetailApi.method, .get)
        XCTAssertEqual(movieDetailApi.path, "/\(apiVersion)/movie/\(testId)")
    }
}
