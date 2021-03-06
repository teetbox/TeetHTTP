//
//  HttpTaskTests.swift
//  TeetHTTPTests
//
//  Created by Matt Tian on 2018/5/3.
//  Copyright © 2018 TeetBox. All rights reserved.
//

import XCTest
@testable import TeetHTTP

extension TaskType: Equatable {
    public static func ==(lhs: TaskType, rhs: TaskType) -> Bool {
        return "\(lhs)" == "\(rhs)"
    }
}

class HttpTaskTests: XCTestCase {
    
    var sut: HttpTask!
    
    let request = URLRequest(url: URL(string: "www.fake.com")!)
    let session = URLSession.shared
    
    let fakeBase = "www.fake.com"
    let fakePath = "/fake/path"
    
    override func setUp() {
        sut = HttpDataTask(request: request, session: session, completion: { _ in })
    }
    
    func testDataTask() {
        let dataTask = sut as! HttpDataTask
        XCTAssert(dataTask.sessionTask is URLSessionDataTask)
    }
    
    func testDataTaskForDownload() {
        sut = HttpDataTask(request: request, session: session, taskType: .download, completion: { _ in })
        XCTAssert((sut as! HttpDataTask).sessionTask is URLSessionDownloadTask)
    }
    
    func testDataTaskForUpload() {
        let content = MultiPartContent(name: "", fileName: "", type: .png, data: Data())
        sut = HttpDataTask(request: request, session: session, taskType: .upload(content), completion: { _ in })
        XCTAssert((sut as! HttpDataTask).sessionTask is URLSessionDataTask)
    }
    
    func testFileTaskForDownload() {
        let progress: ProgressClosure = { _, _, _ in }
        let completed: CompletedClosure = { _, _ in }
        
        sut = HttpFileTask(request: request, session: session, taskType: .download, progress: progress, completed: completed)
        XCTAssertEqual((sut as! HttpFileTask).taskType, .download)
        XCTAssertNotNil((sut as! HttpFileTask).progress)
        XCTAssertNotNil((sut as! HttpFileTask).completed)
        XCTAssert((sut as! HttpFileTask).sessionTask is URLSessionDownloadTask)
    }
    
    func testFileTaskForUpload() {
        let content = MultiPartContent(name: "", fileName: "", type: .png, data: Data())
        let fileRequest = HttpFileRequest(base: fakeBase, path: fakePath, method: .post, params: nil, headers: nil, sessionConfig: .standard, taskType: .upload(content), completed: nil)
        let request = fileRequest.urlRequest!
        
        let progress: ProgressClosure = { _, _, _ in }
        let completed: CompletedClosure = { _, _ in }
        
        sut = HttpFileTask(request: request, session: session, taskType: .upload(content), progress: progress, completed: completed)
        XCTAssertEqual((sut as! HttpFileTask).taskType, .upload(content))
        XCTAssertNotNil((sut as! HttpFileTask).progress)
        XCTAssertNotNil((sut as! HttpFileTask).completed)
        XCTAssert((sut as! HttpFileTask).sessionTask is URLSessionUploadTask)
    }
    
    func testTaskType() {
        let content = MultiPartContent(name: "file", fileName: "swift.jpg", type: .jpg, data: Data())
        
        let data: TaskType = .data
        let download: TaskType = .download
        let upload: TaskType = .upload(content)
        
        XCTAssertEqual(data, TaskType.data)
        XCTAssertEqual(download, TaskType.download)
        XCTAssertEqual(upload, TaskType.upload(content))
    }
    
    func testTaskState() {
        let sessionTask = (sut as! HttpDataTask).sessionTask
        let taskState = TaskState(sessionTask)
        XCTAssertEqual(taskState, .suspended)
        
        let running = TaskState.running
        XCTAssertEqual(running, TaskState.running)
        
        let suspended = TaskState.suspended
        XCTAssertEqual(suspended, TaskState.suspended)
        
        let canceling = TaskState.canceling
        XCTAssertEqual(canceling, TaskState.canceling)
        
        let completed = TaskState.completed
        XCTAssertEqual(completed, TaskState.completed)
    }
    
}
