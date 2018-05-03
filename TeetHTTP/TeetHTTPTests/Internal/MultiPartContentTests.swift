//
//  MultiPartContentTests.swift
//  TeetHTTPTests
//
//  Created by Matt Tian on 2018/5/3.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import XCTest
@testable import TeetHTTP

class MultiPartContentTests: XCTestCase {
    
    var sut: MultiPartContent!
    
    override func setUp() {
        super.setUp()
        
        sut = MultiPartContent(name: "file", fileName: "swift.jpg", type: .jpg, data: Data())
    }
    
    func testInitWithData() {
        XCTAssertEqual(sut.name, "file")
        XCTAssertEqual(sut.fileName, "swift.jpg")
        XCTAssertEqual(sut.type, "image/jpeg")
        XCTAssertEqual(sut.data, Data())
    }
    
    func testInitWithURL() {
        let fileURL = URL(string: "/upload/swift.jpg")!
        sut = MultiPartContent(name: "file", type: .jpg, url: fileURL)
        XCTAssertEqual(sut.name, "file")
        XCTAssertEqual(sut.fileName, "swift.jpg")
        XCTAssertEqual(sut.type, "image/jpeg")
        XCTAssertEqual(sut.url, fileURL)
    }
    
    func testContentType() {
        var contentType = ContentType.data
        XCTAssertEqual(contentType.rawValue, "application/octet-stream")
        
        contentType = ContentType.jpg
        XCTAssertEqual(contentType.rawValue, "image/jpeg")
        
        contentType = ContentType.png
        XCTAssertEqual(contentType.rawValue, "image/png")
    }
    
}
