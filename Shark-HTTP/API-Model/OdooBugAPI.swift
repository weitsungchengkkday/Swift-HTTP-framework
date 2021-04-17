//
//  OdooBugAPI.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/9.
//

import Foundation

final class OdooBugAPI {
    
    private let loader: HTTPLoader
    
    init(loader: HTTPLoader) {
        self.loader = loader
    }
    
    func getBugs(completion: @escaping ([OdooBug]) -> Void) {
        var r = HTTPRequest(scheme: "http")
        r.port = 8069
        r.method = .get
        r.path = "/bm.bug"
    
        loader.load(request: r) { result in
           
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                
                switch response.status {
                case .success:
                    print("✅SUCCESS")
                    guard let data = response.body else {
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonString = json as? [String: Any],
                           let bugs = jsonString["data"] as? [[String: Any]] {
                            
                            let odooBugs = bugs.compactMap { bug -> OdooBug in
                                return OdooBug(name: bug["name"] as! String, detail: bug["detail"] as! String, is_closed: bug["is_closed"] as! Bool, close_reason: bug["close_reason"] as! String)
                            }
                            completion(odooBugs)
                        }
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                    
                    print("OKK")
                default:
                    print("NOT OKK")
                }
                print(response)
            }
        }
        
    }
    
    func getBugWithCondition (completion: @escaping ([OdooBug]) -> Void) {
        var r = HTTPRequest(scheme: "http")
        r.port = 8069
        r.method = .get
        r.path = "/bm.bug"
        r.queryItems = [
            URLQueryItem(name: "limit", value: "2")
        ]
    
        loader.load(request: r) { result in
           
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                
                switch response.status {
                case .success:
                    print("✅SUCCESS")
                    guard let data = response.body else {
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonString = json as? [String: Any],
                           let bugs = jsonString["data"] as? [[String: Any]] {
                            
                            let odooBugs = bugs.compactMap { bug -> OdooBug in
                                return OdooBug(name: bug["name"] as! String, detail: bug["detail"] as! String, is_closed: bug["is_closed"] as! Bool, close_reason: bug["close_reason"] as! String)
                            }
                            completion(odooBugs)
                        }
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                    
                    print("OKK")
                default:
                    print("NOT OKK")
                }
                print(response)
            }
        }
        
    }
    
    func postBug(completion: @escaping ([OdooBug]) -> Void) {
        var r = HTTPRequest(scheme: "http")
       
        r.port = 8069
        r.method = .post
        r.headers = [
            "Content-Type": "application/vnd.api+json",
        ]

        r.path = "bm.bug"
     
        let json =
            ["data": [ "name":"BUGAAAAAA",
                       "detail":"bDDDDDD",
                       "is_closed": true,
                       "close_reason":"cannot"
                     ]
            ]
/// Use DataBody
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        r.body = DataBody(jsonData)
        
/// Use JSONBody
//        r.body = JSONBody(OdooData(data: OdooBug(name: "怪蟲蟲", detail: "很可怕", is_closed: true, close_reason: "cannot")))
//
        
        loader.load(request: r) { result in

            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
             
                switch response.status {
                case .create:
                    print("✅SUCCESS")
                    guard let data = response.body else {
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonString = json as? [String: Any] {
                            print(jsonString)
                           
                            completion([])
                        }
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
              
                    print("OKK")
                default:
                    print("NOT OKK")
                }
                print(response)
            }
        }
    }
    
    func deleteBug(completion: @escaping ([OdooBug]) -> Void) {
        var r = HTTPRequest(scheme: "http")
        
        r.port = 8069
        r.method = .delete
        r.path = "/bm.bug/27"
        
        loader.load(request: r) { result in
           
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                
                switch response.status {
                case .success:
                    print("✅SUCCESS")
                    guard let data = response.body else {
                        return
                    }
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let jsonString = json as? [String: Any],
                           let bugs = jsonString["data"] as? [[String: Any]] {
                            
                            let odooBugs = bugs.compactMap { bug -> OdooBug in
                                return OdooBug(name: bug["name"] as! String, detail: bug["detail"] as! String, is_closed: bug["is_closed"] as! Bool, close_reason: bug["close_reason"] as! String)
                            }
                            completion(odooBugs)
                        }
                    } catch {
                        print("JSON error: \(error.localizedDescription)")
                    }
                    
                    print("OKK")
                default:
                    print("NOT OKK")
                }
                print(response)
            }
        }
    }
    

    
}


struct OdooBug: Codable {
    let name: String
    let detail: String
    let is_closed: Bool
    let close_reason: String
 
}


struct OdooData: Codable {
    let data: OdooBug
}

