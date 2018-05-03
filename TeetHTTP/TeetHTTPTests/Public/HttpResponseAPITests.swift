//
//  HttpResponseAPITests.swift
//  TeetHTTPTests
//
//  Created by Matt Tian on 2018/5/3.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import XCTest
import TeetHTTP

class HttpResponseAPITests: XCTestCase {
    
    var sut: HttpResponse!
    
    func testInit() {
        sut = HttpResponse()
        
        XCTAssertNil(sut.data)
        XCTAssertNil(sut.urlResponse)
        XCTAssertNil(sut.error)
        XCTAssertNil(sut.url)
        XCTAssertNil(sut.json)
        XCTAssertNil(sut.jsonArray)
        XCTAssertEqual(sut.status.description, "0 - Unknown")
    }
    
    func testInitWithData() {
        sut = HttpResponse(data: "some".data(using: .utf8), response: URLResponse(), error: nil)
        
        XCTAssertEqual(sut.data, "some".data(using: .utf8))
        XCTAssertNotNil(sut.urlResponse)
        XCTAssertNil(sut.error)
    }
    
    func testInitWithURL() {
        let url = URL(string: "/download/path")
        sut = HttpResponse(url: url, response: URLResponse(), error: nil)
        
        XCTAssertEqual(sut.url, url)
        XCTAssertNotNil(sut.urlResponse)
        XCTAssertNil(sut.error)
    }
    
}
