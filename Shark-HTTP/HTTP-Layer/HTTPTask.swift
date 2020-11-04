//
//  HTTPTask.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/4.
//

import Foundation

public class HTTPTask {
    public var id: UUID { request.id }
    public var request: HTTPRequest
    public var completion: (HTTPResult) -> Void
    
    public init(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        self.request = request
        self.completion = completion
    }
    
    public func cancel() {
        
    }
    
    public func complete(with result: HTTPResult) {
        completion(result)
    }
    
    public func fail(_ code: HTTPError.Code, response: HTTPResponse? = nil, underlyingError: Error? = nil) {
        let error = HTTPError(code: code, request: request, response: response, underlyingError: underlyingError)
        completion(.failure(error))
    }
}
