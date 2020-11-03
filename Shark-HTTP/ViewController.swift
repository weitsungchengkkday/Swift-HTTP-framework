//
//  ViewController.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let api = TestAPI()
//        api.requestPeople { (peoples) in
//            print(peoples)
//        }
        
//        let mock = MockLoader()
//        mock.then { (request, handler) in
//            print(request.url!)
//        }
        
     //   print(mock.nextHandlers)
        
//        var r = HTTPRequest()
//        r.path = "/Pika"
//        r.host = "weiweishark.com"
//    
//        mock.load(request: r) { result in
//            print(result.response!.status)
//        }
        
//        sequentialExecutions()
      
        
        
//        let sessionLoader = URLSessionLoader(session: URLSession.shared)
//        let printLoader = PrintLoader()
//
//        printLoader.nextLoader = sessionLoader
//        let loader: HTTPLoader = printLoader
//
//        let api2 = TestAPI(loader: loader)
//        api2.requestPeople { peoples in
//            print(peoples[1].first_name)
//        }
        
       
        
        
        let applyLoader = ApplyEnvironment(environment: ServerEnvironment(host: ""))
        
        let sessionLoader = URLSessionLoader(session: URLSession.shared)
        applyLoader.nextLoader = sessionLoader
        
        let printLoader = PrintLoader()
        printLoader.nextLoader = applyLoader

        let loader: HTTPLoader = printLoader

        let api3 = StarWarsAPI(loader: loader)
        api3.requestPeople { peoples in
            print(peoples[0].name)
        }
  
       
    }

}



func sequentialExecutions() {
    let mock = MockLoader()
    for i in 0 ..< 5 {
        mock.then { request, handler in

//            print(request.path!)
            let responseJson = """
                {
                    "\(i*100)": \(i)
                }
            """
    
            let responseData = Data(responseJson.utf8)
            
            handler(.success(HTTPResponse(request: request, response: HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "1.7", headerFields: nil)!, body: responseData)))
        }
        
        
    }

    for i in 0 ..< 5 {
        var r = HTTPRequest()
        r.path = "/\(i)"
        mock.load(request: r) { httpResult in
//            print(httpResult.request.path)
            if let data = httpResult.response?.body {
                do {
                  let jsonData =  try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonData)
                } catch(let error) {
                    print(error)
                }
            }
        }
    }

}
