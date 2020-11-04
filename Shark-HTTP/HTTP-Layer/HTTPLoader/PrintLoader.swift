//
//  PrintLoader.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/10/30.
//

import Foundation

public class PrintLoader: HTTPLoader {
    
    open override func load(task: HTTPTask) {
        print("Loading \(task.request)")
        print("_________________")
        let completion = task.completion
        
        task.completion = { result in
            print("GO result: \(result)")
            print("___________________")
            completion(result)
        }
        
        super.load(task: task)
    }
    
//    public override func reset(compleitonHandler: @escaping () -> Void) {
//       
//        super.reset() {
//            print("reset print loader")
//            compleitonHandler()
//        }
//    }
}

