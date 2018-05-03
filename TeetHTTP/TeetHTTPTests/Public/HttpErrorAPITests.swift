//
//  HttpErrorAPITests.swift
//  TeetHTTPTests
//
//  Created by Matt Tian on 2018/5/3.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import XCTest
import TeetHTTP

class HttpErrorAPITests: XCTestCase {
    
    var sut: TeetHTTP!
    
    let fakeBase = "http://www.fake.com"
    let fakePath = "/fake/path"
    
    override func setUp() {
        super.setUp()
        
        sut = TeetHTTP(base: fakeBase)
    }
    
    func testInvalidURL() {
        sut = TeetHTTP(base: "")
        sut.get("") { response in
            XCTAssertEqual(response.error?.localizedDescription, "Invalid url: ")
        }
    }
    
    func testDataRequestInBackgroundSession() {
        sut = TeetHTTP(base: fakeBase, config: .background("bg"))
        sut.get(fakePath) { response in
            XCTAssertEqual(response.error?.localizedDescription, "Data request can't run in background session")
        }
    }
    
    func testDataRequestWithParamsAndBodyDataUsingPostMethod() {
        let request = sut.dataRequest(path: fakePath, method: .post, params: ["paramKey": "paramValue"], bodyData: Data())
        request.go { response in
            XCTAssertEqual(response.error?.localizedDescription, "Params and bodyData should not be used together in POST request")
        }
    }
    
    func testDateRequestWithParamsAndBodyDataUsingGetMethod() {
        let request = sut.dataRequest(path: fakePath, method: .get, params: ["paramKey": "paramValue"], bodyData: Data())
        
        let task = request.go { _ in }
        XCTAssertNotNil(task)
    }
    
}
