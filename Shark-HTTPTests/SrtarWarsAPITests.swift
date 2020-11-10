//
//  SrtarWarsAPITests.swift
//  Shark-HTTPTests
//
//  Created by WEI-TSUNG CHENG on 2020/10/30.
//

import XCTest
@testable import Shark_HTTP

class SrtartWarsAPITests: XCTestCase {
    
    let mock = MockLoader()
    lazy var api: TestAPI = { TestAPI(loader: mock)}()
    
    func test_200_OK_WithValidBody() {
        
        let responseJson = """
            [
                {
                  "age": 3,
                  "first_name": "Allen",
                  "last_name": "Lee",
                },
                {
                  "age": 5,
                  "first_name": "Will",
                  "last_name": "Cheng",
                }
            ]
        """
        
        let responseData = Data(responseJson.utf8)
        
        mock.then { (request, handler) in
            handler(.success(.init(request: request, response: HTTPURLResponse(url: request.url!, statusCode: 204, httpVersion: "1.1", headerFields: nil)!, body: responseData)))
        }
        
        api.requestPeople { (peoples) in
            XCTAssertEqual(peoples[1].first_name, "Will")
        }
    }
    
    
}
