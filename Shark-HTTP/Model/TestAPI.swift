//
//  TestAPI.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/28.
//

import Foundation
import DolphinHTTP

class TestAPI {

    private let loader: HTTPLoader
        
    public init(loader: HTTPLoader = URLSessionLoader(session: URLSession.shared)) {
        
        let modifier = ModifyRequest { request -> HTTPRequest in
            
            var copy = request
            
            if let host = copy.host {
                if host.isEmpty  {
                    copy.host = "learnappmaking.com"
                }
            } else {
                copy.host = "learnappmaking.com"
            }
            
            if let path = copy.path {
                if path.hasPrefix("/") == false {
                    copy.path = "/ex/" + path
                } else {
                    copy.path = "/ex" + path
                }
            } else {
                copy.path = "/ex"
            }
            
//            print(copy.url)
            return copy
        }
        
        self.loader = modifier --> loader //?? HTTPLoader()
    }
    //https://learnappmaking.com/ex/books.json
    
    public func requestPeople(completion: @escaping(([TestPeople]) -> Void)) {
        var r = HTTPRequest()
        r.path = "/users.json"
//        r.host = "learnappmaking.com"
//        r.path = "/ex/users.json"
    
        loader.load(request: r) { result in
//            let json = try! JSONSerialization.jsonObject(with: (result.response?.body)!, options: [])
//            print(json)
//            print(result.response?.body)
            
            let peoples = try! JSONDecoder().decode([TestPeople].self, from: (result.response?.body)!)
            completion(peoples)
        }
        
    
    }
}


struct TestPeople: Codable {
    let age: Int
    let first_name: String
    let last_name: String

}
