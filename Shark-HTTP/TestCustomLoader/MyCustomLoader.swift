//
//  MyCustomLoader.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/3.
//

import Foundation
import DolphinHTTP

class MyCustomLoader: HTTPLoader {
    
    override func reset(with group: DispatchGroup) {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            print("reset - One")
            group.leave()
        }
        super.reset(with: group)
    }
    
}

