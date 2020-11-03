//
//  HTTPLoader.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/27.
//

import Foundation
//
//public protocol HTTPLoading {
//    func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void)
//}

open class HTTPLoader {
    public var nextLoader: HTTPLoader? {
        willSet {
            guard nextLoader == nil else { fatalError("The nextLoader may only be set once") }
        }
    }
    
    public init() { }
    
    open func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        if let next = nextLoader {
            next.load(request: request, completion: completion)
        } else {
            let error = HTTPError(code: .cannotConnect, request: request, response: nil, underlyingError: nil)
            completion(.failure(error))
        }
    }
    
//    open func reset(compleitonHandler: @escaping () -> Void) {
//        print("reset")
//        if let next = nextLoader {
//            print(next)
//            next.reset(compleitonHandler: compleitonHandler)
//        } else {
//            print("no more reset")
//            compleitonHandler()
//        }
//    }
    
    open func reset(with group: DispatchGroup) {
        nextLoader?.reset(with: group)
    }
}

extension HTTPLoader {
    
    public final func reset(on queue: DispatchQueue = .main, completionHandler: @escaping ()-> Void) {
        let group = DispatchGroup()
        self.reset(with: group)
        
        group.notify(queue: queue, execute: completionHandler)
    }
}



//
//extension URLSession: HTTPLoading {
//    public func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
//        guard let url = request.url else {
//            completion(.failure(.init(code: .invalidRequest, request: request, response: nil, underlyingError: nil)))
//            return
//        }
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = request.method.rawValue
//
//        for (header, value) in request.headers {
//            urlRequest.addValue(value, forHTTPHeaderField: header)
//        }
//
//        if request.body.isEmpty == false {
//            for (header, value) in request.body.additionalHeaders {
//                urlRequest.addValue(value, forHTTPHeaderField: header)
//            }
//
//            do {
//                urlRequest.httpBody = try request.body.encode()
//
//            } catch {
//                completion(.failure(.init(code: .invalidRequest, request: request, response: nil, underlyingError: nil)))
//                return
//            }
//        }
//
//        let dataTask = self.dataTask(with: urlRequest) { (data, response, error) in
//            var httpResponse: HTTPResponse?
//            if let r = response as? HTTPURLResponse {
//                httpResponse = HTTPResponse(request: request, response: r, body: data)
//            }
//
//            if let e = error as? URLError {
//                let code: HTTPError.Code
//                switch e.code {
//                    case .badURL: code = .invalidRequest
//                    case .unsupportedURL: code = .invalidRequest
//                    case .cannotFindHost: code = .invalidRequest
//                    default:
//                    code = .unknown
//                }
//                completion(.failure(HTTPError(code: code, request: request, response: httpResponse, underlyingError: e)))
//
//            } else if let someError = error {
//                completion(.failure(HTTPError(code: .unknown, request: request, response: httpResponse, underlyingError: someError)))
//
//            } else if let res = httpResponse {
//                completion(.success(res))
//
//            } else {
//                completion(.failure(HTTPError(code: .invalidResponse, request: request, response: nil, underlyingError: error)))
//            }
//        }
//
//        dataTask.resume()
//
//    }
//}


//class AnyLoader: HTTPLoading {
//    
//    
//    private let loader: HTTPLoading
//    
//    init(_ other: HTTPLoading) {
//        self.loader = other
//    }
//    
//    func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
//        loader.load(request: request, completion: completion)
//    }
//    
//}
