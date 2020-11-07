//
//  AutoCancel.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/6.
//

import Foundation

public class AutoCancel: HTTPLoader {
    private let queue = DispatchQueue(label: "Auto Cancel Loader Queue")
    private var currentTasks = [ UUID : HTTPTask ]()
    
    public override func load(task: HTTPTask) {
        queue.sync {
            let id = task.id
            currentTasks[id] = task
            task.addCompletionHandler {
                self.queue.sync {
                   self.currentTasks[id] = nil
                 
                }
            }
        }
        super.load(task: task)
    }
    
    public override func reset(with group: DispatchGroup) {
        print("E1")
        group.enter()
        queue.async {
            let copy = self.currentTasks // 10
            self.currentTasks = [:]
            DispatchQueue.global(qos: .userInitiated).async {
                print("🅾️")
                print(copy.values.count)
                for task in copy.values {
//                    print("E2")
//                    group.enter()
//                    task.addCompletionHandler {
//                        print("L2")
//                        group.leave()
//                    }
                    task.cancel()
                }
                print("L1")
                group.leave()
            }
        }
        
        nextLoader?.reset(with: group)
    }
    
}

//讀寫個做一次保護
