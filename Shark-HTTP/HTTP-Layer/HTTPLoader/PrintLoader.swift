//
//  PrintLoader.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/30.
//

import Foundation

public class PrintLoader: HTTPLoader {
    public override func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        print("Loading \(request)")
        print("_________________")
        super.load(request: request) { result in
            print("GO result: \(result)")
            print("___________________")
            completion(result)
        }
    }
}

