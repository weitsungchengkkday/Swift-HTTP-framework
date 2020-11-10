//
//  OdooBugAPITests.swift
//  Shark-HTTPTests
//
//  Created by WEI-TSUNG CHENG on 2020/11/10.
//

import Foundation

import XCTest
@testable import Shark_HTTP

class OdooAPITests: XCTestCase {
    let mock = MockLoader()
   
    lazy var api: OdooBugAPI = {
        return OdooBugAPI(loader: mock)
    }()
 
    func test_OK_WithValidRequest() {
        
        let responseJson = """
        {
            "data": [
                        {
                            "detail": "AAAAAA",
                            "is_closed": false,
                            "close_reason": "cannot",
                            "name": "bug A",
                        },
                        {
                            "detail": "BBBBBB",
                            "is_closed": true,
                            "close_reason": "cannot",
                            "name": "bug B",
                        }
            ]
        }
        """
        
        let responseData = Data(responseJson.utf8)
        
        let responseJson2 = """
        {
            "data": [
                        {
                            "detail": "CCCCCC",
                            "is_closed": false,
                            "close_reason": "cannot",
                            "name": "bug C",
                        }
                      
            ]
        }
        """
        let responseData2 = Data(responseJson2.utf8)
        
        
        mock
            .then { (request, handler) in
                print("🥎")
                handler(.success(.init(request: request, response: HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "1.1", headerFields: nil)!, body: responseData)))
            }
            .then { (request, handler) in
                print("🥎🥎")
                handler(.success(.init(request: request, response: HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "1.1", headerFields: nil)!, body: responseData2)))
               
        }
        
        api.getBugs { bugs in
            XCTAssertEqual(bugs.count, 2)
            
        }
        
        api.getBugs { bugs in
            XCTAssertEqual(bugs.count, 1)
        }
        
    }
    
}
