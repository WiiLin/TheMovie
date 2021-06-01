//
//  WLURLTest.swift
//  TheMovieTests
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

@testable import TheMovie
import XCTest

class WLURLTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testURLNotNil() throws {
        XCTAssertNotNil(URL.apiHost)
        XCTAssertNotNil(URL.movieImageHost)
        XCTAssertNotNil(URL.bookURLHost)
        
        XCTAssertNotNil(URL.movieApi(path:WLApiPath.movieList.path))
        XCTAssertNotNil(URL.movieApi(path:WLApiPath.movieDetail.path))
        
        XCTAssertNotNil(URL.movieImage(path:"/eTRV0TlIcXxs2YieXT6O3REcoo9.jpg"))
        
        XCTAssertNotNil(URL.book(id:123))
        
    }

}
