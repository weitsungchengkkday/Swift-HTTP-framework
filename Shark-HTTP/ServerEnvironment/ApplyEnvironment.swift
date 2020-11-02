//
//  ApplyEnvironment.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/2.
//

import Foundation

public class ApplyEnvironment: HTTPLoader {
    
    private let environment: ServerEnvironment
    public init(environment: ServerEnvironment) {
        self.environment = environment
        super.init()
    }
    
    public override func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        
        var copy = request
        
        let requestEnvironment = request.serverEnvironment ?? environment
        
        if let host = copy.host, host.isEmpty {
            copy.host = requestEnvironment.host
        } else {
            copy.host = requestEnvironment.host
        }
        
        if let path = copy.path {
            if path.hasPrefix("/") == false {
                copy.path = requestEnvironment.pathPrefix + path
            } else {
                copy.path = requestEnvironment.pathPrefix + path
                
            }
        }
        
        for (header, value) in requestEnvironment.headers {
            copy.headers[header] = value
        }
        
        super.load(request: copy, completion: completion)
    }
}
