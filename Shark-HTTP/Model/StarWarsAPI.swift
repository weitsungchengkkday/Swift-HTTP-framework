//
//  StarWarsAPI.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/2.
//

import Foundation

class StarWarsAPI {
    private let loader: HTTPLoader

    public init(loader: HTTPLoader = URLSessionLoader(session: URLSession.shared)) {
        
        self.loader = loader
    }

    public func requestPeople(completion: @escaping ([StartWarsPeople]) -> Void) {
        
        var r = HTTPRequest()
        r.serverEnvironment = .testServer
        r.path = "/people"
        r.queryItems = [
            URLQueryItem(name: "search", value: "anakin")
        ]
    
        loader.load(request: r) { result in
            
            switch result{
            case.failure(let error):
                 print("ERROR: \(error)")
            case .success(let response):
                print("SUCCESS")
                guard let data = response.body else {
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) // Read Option
                    if let jsonString = json as? [String: Any],
                       let results = jsonString["results"] as? [[String: Any]]{
                        
                        let name = results[0]["name"] as! String
                        let height = results[0]["height"] as! String
                        
                        completion([StartWarsPeople(name: name, height: Int(height)!)])
                        
                    }
                    
                    //                   , let results = jsonString["results"] as? [String: Any] {
                    //
                    //                    print(results)
                    //
                    //                }
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
                
                
            }
            
        }
    }
    
    
//    func resetTest() {
//        loader.reset {
//            print("reset finish")
//        }
//    }
    
        func resetTestV2() {
            loader.reset {
                print("Reset-Finish")
            }
        }
    
}


struct StartWarsPeople: Codable {
    let name: String
    let height: Int
}



