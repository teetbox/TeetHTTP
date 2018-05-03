//
//  MultiPartContentAPITests.swift
//  TeetHTTPTests
//
//  Created by Matt Tian on 2018/5/3.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import XCTest
import TeetHTTP

class MultiPartContentAPITests: XCTestCase {
    
    var sut: MultiPartContent!
    
    func testInitWithData() {
        sut = MultiPartContent(name: "file", fileName: "swift.jpg", type: .jpg, data: Data())
        XCTAssertNotNil(sut)
    }
    
    func testInitWithURL() {
        let fileURL = URL(string: "/upload/swift.jpg")!
        sut = MultiPartContent(name: "file", type: .jpg, url: fileURL)
        XCTAssertNotNil(sut)
    }
    
}
