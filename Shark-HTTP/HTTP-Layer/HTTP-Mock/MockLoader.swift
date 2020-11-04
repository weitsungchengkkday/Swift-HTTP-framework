//
//  MockLoader.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/28.
//

import Foundation
//
//public class MockLoader: HTTPLoading {
//
//    public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
//        let urlResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "1.1", headerFields: nil)!
//        let response = HTTPResponse(request: request, response: urlResponse, body: nil)
//        completion(.success(response))
//    }
//}


//extension HTTPLoading {
//    func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
//
//    }
//}


//public class Mock: HTTPLoading {
//    public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
//        let urlResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "1.1", headerFields: nil)!
//        let response = HTTPResponse(request: request, response: urlResponse, body: nil)
//        completion(.success(response))
//    }
//
//}

public class MockLoader: HTTPLoader {
    
    public typealias HTTPHandler = (HTTPResult) -> Void
    public typealias MockHandler = (HTTPRequest, HTTPHandler) -> Void
    
    public var nextHandlers = Array<MockHandler>()
    
    open override func load(task: HTTPTask) {
        if nextHandlers.isEmpty == false {
            let next = nextHandlers.removeFirst()
            next(task.request, task.completion)
        } else {
            task.fail(.cannotConnect)
        }
    }
    
//    public override func load(request: HTTPRequest, completion: @escaping HTTPHandler) {
//
////        print(nextHandlers)
//        if nextHandlers.isEmpty == false {
//            let next = nextHandlers.removeFirst()
//            next(request, completion)
//        } else {
//            let error = HTTPError(code: .cannotConnect, request: request, response: nil, underlyingError: nil)
//            completion(.failure(error))
//        }
//    }
    
    @discardableResult
    public func then(_ handler: @escaping MockHandler) -> MockLoader {
        nextHandlers.append(handler)
        return self
    }
}




