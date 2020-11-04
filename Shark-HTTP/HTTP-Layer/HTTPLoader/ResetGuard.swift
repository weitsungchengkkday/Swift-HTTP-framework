//
//  ResetGuard.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/3.
//

import Foundation

public class ResetGuard: HTTPLoader {
    @AtomicTransaction(wrappedValue: false, queue: DispatchQueue(label: "reset Guard Queue", qos: .background))
    private var isResetting
    
    open override func load(task: HTTPTask) {
        if isResetting == false {
            super.load(task: task)
        } else {
            task.fail(.resetInProgress)
        }
    }
    
    //    public override func load(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
    //
    //        if isResetting == false {
    //            super.load(request: request, completion: completion)
    //        } else {
    //            let error = HTTPError(code: .resetInProgress, request: request, response: nil, underlyingError: nil)
    //            completion(.failure(error))
    //        }
    //    }
    
    public override func reset(with group: DispatchGroup) {
        
        //  print(Thread.current.isMainThread)
        if isResetting == true {
            return
        }
        guard let next = nextLoader else { return }
        print("guard reset in")
        group.enter()
        
        _isResetting.mutate { bool in
            bool = true
        }
        //        isResetting = true
        next.reset {
            //     print(Thread.current.isMainThread)
            self._isResetting.mutate { bool in
                bool = false
            }
            //  self.isResetting = false
            print("guard reset out")
            group.leave()
        }
    }
}

