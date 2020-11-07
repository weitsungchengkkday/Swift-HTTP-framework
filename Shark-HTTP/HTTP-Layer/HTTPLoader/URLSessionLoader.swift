//
//  URLSessionLoader.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/30.
//

import Foundation

open class URLSessionLoader: HTTPLoader {
    var session: URLSession
    init(session: URLSession) {
        self.session = session
        super.init()
    }
    
    open override func load(task: HTTPTask) {
    
        let request = task.request
        guard let url = request.url else {
            task.fail(.invalidRequest)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        for (header, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }
        
        if request.body.isEmpty == false {
            for (header, value) in request.body.additionalHeaders {
                urlRequest.addValue(value, forHTTPHeaderField: header)
            }
            
            do {
                urlRequest.httpBody = try request.body.encode()
                
            } catch {
                task.fail(.invalidRequest)
                return
            }
        }
        
        let dataTask = self.session.dataTask(with: urlRequest) { (data, response, error) in
            var httpResponse: HTTPResponse?
            if let r = response as? HTTPURLResponse {
                httpResponse = HTTPResponse(request: request, response: r, body: data)
            }
            
            if let e = error as? URLError {
                let code: HTTPError.Code
                switch e.code {
                case .badURL: code = .invalidRequest
                case .unsupportedURL: code = .invalidRequest
                case .cannotFindHost: code = .invalidRequest
                case .cancelled: code = .cancelled
                default:
                    code = .unknown
                }
                task.fail(code, response: httpResponse, underlyingError: e)
                
            } else if let someError = error {
                task.fail(.unknown, response: httpResponse, underlyingError: someError)
                
            } else if let res = httpResponse {
                task.complete(with: .success(res))
                
            } else {
                task.fail(.invalidResponse, response: nil, underlyingError: error)
            }
        }
  
        task.addCancellationHandler {
            
            switch dataTask.state {
            case .canceling:
                return
            case .completed:
                return
            case .running:
                dataTask.cancel()
                return
            case .suspended:
                dataTask.cancel()
                return
            @unknown default:
                return
            }
        }
        
        dataTask.resume()
    }
    
    
    //    public override func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
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
    //        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
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
    //    }
    
    //    public override func reset(compleitonHandler: @escaping () -> Void) {
    //
    //        super.reset() {
    //            print("reset session loader")
    //            compleitonHandler()
    //        }
    //    }
}

