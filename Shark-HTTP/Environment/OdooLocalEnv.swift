//
//  OdooLocalEnv.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/10.
//

import Foundation

// OdooLocalEnv
extension ServerEnvironment {
    static let odooLocal = ServerEnvironment(host: "localhost", pathPrefix: "/api/v1", headers: [
        "Authorization" : "KKday id=\"EKsytzEUWHAu9HT8CeXuQSrWCscsfO\",ts=\"1810054342.1\",user=\"admin\"",
        "Accept" : "application/vnd.api+json",
        "KK-Track-ID" : "0",
        "KK-Track-SEQ" : "0"
    ], query: [])
    
    
}
