//
//  Shark_HTTPTests.swift
//  Shark-HTTPTests
//
//  Created by WEI-TSUNG CHENG on 2020/10/26.
//

import XCTest
@testable import Shark_HTTP

class Shark_HTTPTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_sequentialExecutions() {
        let mock = MockLoader()
        for i in 0 ..< 5 {
            mock.then { request, handler in
                XCTAssert(request.path! == "/\(i)")
            }
        }

        for i in 0 ..< 5 {
            var r = HTTPRequest()
            r.path = "/\(i)"
            mock.load(request: r) { result in
                XCTAssertEqual(result.response?.status, .success)
            }
        }

    }

}
