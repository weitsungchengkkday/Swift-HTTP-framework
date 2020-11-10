//
//  TestEnv.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/10.
//

import Foundation

extension ServerEnvironment {
    
    public static let development = ServerEnvironment(host: "development.example.com", pathPrefix: "/api-dev")
    public static let qa = ServerEnvironment(host: "qa-1.example.com", pathPrefix: "/api")
    public static let staging = ServerEnvironment(host: "api-staging.example.com", pathPrefix: "/api")
    public static let production = ServerEnvironment(host: "api.example.com", pathPrefix: "/api")
    public static let testServer = ServerEnvironment(host: "swapi.dev", pathPrefix: "/api", headers: ["Content-Type":"application/json"])
}

