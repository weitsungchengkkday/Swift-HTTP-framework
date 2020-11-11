//
//  ViewController.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/26.
//

import UIKit
import DolphinHTTP

class ViewController: UIViewController {

    var api3: StarWarsAPI!
    var api4: OdooBugAPI!
    var api5: TwilioAPI!
    
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
      
        
       
//        let applyLoader = ApplyEnvironment(environment: ServerEnvironment(host: ""))
//        let sessionLoader = URLSessionLoader(session: URLSession.shared)
//        applyLoader.nextLoader = sessionLoader
//        let printLoader = PrintLoader()
//        printLoader.nextLoader = applyLoader
//        let loader: HTTPLoader = printLoader
//        let api3 = StarWarsAPI(loader: loader)
//        api3.requestPeople { peoples in
//            print(peoples[0].name)
//        }
//        api3.resetTest()
        
        
//        let sessionLoader = URLSessionLoader(session: URLSession.shared)
//        let m1 = MyCustomLoader()
//        let m2 = MyCustomLoaderTwo()
//        m1.nextLoader = m2
//        m2.nextLoader = sessionLoader
//        let loader: HTTPLoader = m1
//        let api3 = StarWarsAPI(loader: loader)
//        api3.requestPeople { peoples in
//            print(peoples[0].name)
//        }
//        api3.resetTestV2()
        
        
//        var arr = ThreadSafeArray<Int>(array: [1,2,3,4])
//        let p = arr.remove(at: 3)
//
    
        
        
//        let printLoader = PrintLoader()
//        let mr = ResetGuard()
//        let autoCancelLoader = AutoCancel()
//        let applyLoader = ApplyEnvironment(environment: ServerEnvironment(host: ""))
//        let sessionLoader = URLSessionLoader(session: URLSession.shared)
//
//        let loader: HTTPLoader = applyLoader
//
////        printLoader --> mr
////        mr --> autoCancelLoader
////        autoCancelLoader --> applyLoader
////        applyLoader --> sessionLoader
////
//        applyLoader --> sessionLoader
//
//        api3 = StarWarsAPI(loader: loader)
       
        
    
        
        let printLoader = PrintLoader()
        let sessionLoader1 = URLSessionLoader()
        let serverEnviroment = ServerEnvironment.odooLocal
        let applyEnviroment = ApplyEnvironment(environment: serverEnviroment)
        
        printLoader --> applyEnviroment
        applyEnviroment --> sessionLoader1
        
        api4 = OdooBugAPI(loader: printLoader)
        
        
        
        
        let sessionLoader2 = URLSessionLoader()
        api5 = TwilioAPI(loader: sessionLoader2)
        
         
     
    }
    
    
    @IBAction func CallAPI1(_ sender: UIButton) {
//        api3.requestPeople { peoples in
//            print("API 1: \(peoples[0].name)")
//        }
        
//        print(autoCancelLoader.currentTasks.count)
//
//        api3.requestPlanets { planets in
//            print("API 2: \(planets[0].name)")
//        }
//
     //   print(autoCancelLoader.currentTasks.count)

//
//        api4.getBugs { (odooBugs) in
//            print(odooBugs)
//        }

        api4.getBugWithCondition { bugs in
            print(bugs)
        }
      
        
    }
    
    
    @IBAction func CallAPI2(_ sender: UIButton) {
//        print(autoCancelLoader.currentTasks.count)
//        api3.resetPlanets()

        api4.postBug { (odooBugs) in
            print(odooBugs)
        }
    }
    
    @IBAction func CancelAPI1(_ sender: UIButton) {
       
        
        api4.deleteBug { (odooBugs) in
            print(odooBugs)
        }
    }
    
    
    
    @IBAction func CancelAPI2(_ sender: UIButton) {
        api5.postData { data in
            print(data)
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
