//
//  TwilioAPIPostWithDataBodyTwo.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2021/4/17.
//

import Foundation

final class TwilioAPIPostWithDataBodyTwo {
    
    private let loader: HTTPLoader
    
    init(loader: HTTPLoader) {
        self.loader = loader
    }
    
    func postData(url: URL, completion: @escaping (String) -> Void) {
        var r = HTTPRequest()
        r.host = url.host
        r.path = url.path
        r.method = .post
        
        let jsonDic = ["client_token": "The_shortest_answer_is_doing"]
        
        let jsonData: Data? = try? JSONEncoder().encode(jsonDic)
    
        r.body = DataBody(jsonData!)
        r.headers = ["Content-Type": "application/json; charset=utf8"]
        
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
