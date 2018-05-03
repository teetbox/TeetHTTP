//
//  HttpTaskAPITests.swift
//  TeetHTTPTests
//
//  Created by Matt Tian on 2018/5/3.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import XCTest
import TeetHTTP

class HttpTaskAPITests: XCTestCase {
    
    var sut: HttpTask!
    
    let fakeBase = "http://www.fake.com"
    let fakePath = "/fake/path"
    
    override func setUp() {
        super.setUp()
        
        sut = TeetHTTP(base: fakeBase).get(fakePath) { _ in }
    }
    
    func testSuspend() {
        sut.suspend()
        XCTAssertEqual(sut.state, .suspended)
    }
    
    func testResume() {
        sut.resume()
        XCTAssertEqual(sut.state, .running)
    }
    
    func testCancel() {
        sut.cancel()
        XCTAssertEqual(sut.state, .canceling)
    }
    
}
