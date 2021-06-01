//
//  WLFakeApiTest.swift
//  TheMovieTests
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

@testable import TheMovie
import XCTest

class WLFakeApiTest: XCTestCase {
    let fakeApiCenter: WLRequestProtocol = WLFakeApiCenter()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMovieListApiParse() throws {
        let apiExpectation = expectation(description: "apiExpectation")
        fakeApiCenter.discoverMovies(page: 1, sort: .popularity) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case let .failure(error):
                print(error.description)
                XCTAssertTrue(false)
            }
            apiExpectation.fulfill()
        }
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testMovieDetailApiParse() throws {
        let apiExpectation = expectation(description: "apiExpectation")
        fakeApiCenter.getMovieDetail(id: 0) { result in
            switch result {
            case .success:
                XCTAssertTrue(true)
            case let .failure(error):
                print(error.description)
                XCTAssertTrue(false)
            }
            apiExpectation.fulfill()
        }
        waitForExpectations(timeout: 20) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
