//
//  HTTPRequest.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/26.
//

import Foundation

public struct HTTPRequest {
    private var urlComponents = URLComponents()
    public var method: HTTPMethod = .get
    public var headers: [String: String] = [:]
    public var body: HTTPBody = EmptyBody()
    
    private var options = [ObjectIdentifier: Any]()
    
    public subscript<O: HTTPRequestOption>(option type: O.Type) -> O.Value {
        get {
        
            let id = ObjectIdentifier(type)
            
            print(type.defaultOptionValue)
            guard let value = options[id] as? O.Value else {
                return type.defaultOptionValue
            }
            
            return value
        }

        set {
            let id = ObjectIdentifier(type)
            print(newValue)
            options[id] = newValue
        }
    }
    
    public init() {
        urlComponents.scheme = "https"
    }
}


public extension HTTPRequest {
    
    var scheme: String { urlComponents.scheme ?? "https" }
    
    var url: URL? { urlComponents.url }
    
    var host: String? {
        get { urlComponents.host }
        set { urlComponents.host = newValue}
    }
    
    var path: String? {
        get { urlComponents.path }
        set { urlComponents.path = newValue ?? "" }
    }
    
    var queryItems: [URLQueryItem]? {
        get { urlComponents.queryItems }
        set { urlComponents.queryItems = newValue}
    }
    
}

extension HTTPRequest {
    public var serverEnvironment: ServerEnvironment? {
        get {
            self[option: ServerEnvironment.self]
        }
        set {
            self[option: ServerEnvironment.self] = newValue
        }
    }
}
