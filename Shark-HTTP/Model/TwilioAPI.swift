//
//  TwilioAPI.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/10.
//

import Foundation
import DolphinHTTP

final class TwilioAPI {
    
    private let loader: HTTPLoader
    
    init(loader: HTTPLoader) {
        self.loader = loader
    }
    
    func postData(completion: @escaping (TwilioData) -> Void) {
        var r = HTTPRequest()
        r.host = "studio.twilio.com"
        r.path = "/v2/Flows/FWc8546f29786f758d5f8bc0a4468630fe/Executions"
        r.headers = [
            "Authorization" : "Basic QUM0ZTcyZDBmMDcxNjk2ZTFkNDQzMjA0NzdjMTJhYWNhYTpkODU1ZTIzOTkwYThiZDRjZGFiNDg5ZmU2YzliMTFlYw=="
        ]
        r.method = .post
        r.body = FormBody([
            URLQueryItem(name: "To", value: "+886989233699"),
            URLQueryItem(name: "From", value: "+15017122661")
        ])
        
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
                            
                            completion(TwilioData(status: jsonString["status"] as! String, contact_channel_address: jsonString["contact_channel_address"] as! String))
                            
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

struct TwilioData: Codable {
    let status: String
    let contact_channel_address: String
}
