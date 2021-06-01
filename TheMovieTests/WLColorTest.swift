//
//  WLColorTest.swift
//  TheMovieTests
//
//  Created by Wii Lin on 2021/6/1.
//  Copyright © 2021 Wii Lin. All rights reserved.
//

@testable import TheMovie
import XCTest

class WLColorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testColorNotNil() throws {
        XCTAssertNotNil(UIColor.lightGreen)
        XCTAssertNotNil(UIColor.backgroundBlack)
        XCTAssertNotNil(UIColor.deepRed)
        XCTAssertNotNil(UIColor.pink)
        
    }
}
