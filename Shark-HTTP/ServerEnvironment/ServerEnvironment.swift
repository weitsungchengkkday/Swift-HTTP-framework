//
//  ServerEnvironment.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/30.
//

import Foundation

public struct ServerEnvironment: HTTPRequestOption {
    
    public var host: String
    public var pathPrefix: String
    public var headers: [String: String]
    public var query: [URLQueryItem]
    
   // public typealias Value = ServerEnvironment
    public static var defaultOptionValue: ServerEnvironment? = nil
    
    public init(host: String, pathPrefix: String = "/", headers: [String: String] = [:], query: [URLQueryItem] = []) {
        let prefix = pathPrefix.hasPrefix("/") ? "" : "/"
        self.host = host
        self.pathPrefix = prefix + pathPrefix
        self.headers = headers
        self.query = query
    }
    
}

extension ServerEnvironment {
    public static let development = ServerEnvironment(host: "development.example.com", pathPrefix: "/api-dev")
    public static let qa = ServerEnvironment(host: "qa-1.example.com", pathPrefix: "/api")
    public static let staging = ServerEnvironment(host: "api-staging.example.com", pathPrefix: "/api")
    public static let production = ServerEnvironment(host: "api.example.com", pathPrefix: "/api")
    public static let testServer = ServerEnvironment(host: "swapi.dev", pathPrefix: "/api", headers: ["Content-Type":"application/json"])
}
