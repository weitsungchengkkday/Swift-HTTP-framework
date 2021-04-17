//
//  TwilioAPIPostWithJSONBody.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2021/4/17.
//

import Foundation

final class TwilioAPIPostWithJSONBody {
    
    private let loader: HTTPLoader
    
    init(loader: HTTPLoader) {
        self.loader = loader
    }
    
    func postData(url: URL, completion: @escaping (String) -> Void) {
        var r = HTTPRequest()
        r.host = url.host
        r.path = url.path
        r.method = .post
        
        r.body = JSONBody(TwilioToken(client_token: "The_shortest_answer_is_doing"))
 
        loader.load(request: r) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                print(response)
                
                let text = String(data: response.body!, encoding: .utf8)
                print(text!)
            }
        }
        
    }
    
}

struct TwilioToken: Codable {
    let client_token: String
}
