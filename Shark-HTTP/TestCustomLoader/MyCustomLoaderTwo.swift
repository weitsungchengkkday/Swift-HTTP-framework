//
//  MyCustomLoaderTwo.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/3.
//

import Foundation

class MyCustomLoaderTwo: HTTPLoader {
    
    override func reset(with group: DispatchGroup) {
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            print("reset - Two")
            group.leave()
        }
        super.reset(with: group)
    }
    
}
