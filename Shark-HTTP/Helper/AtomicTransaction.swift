//
//  AtomicTransaction.swift
//  Shark-HTTP
//
//  Created by WEI-TSUNG CHENG on 2020/11/4.
//

import Foundation

@propertyWrapper
final class AtomicTransaction<V> {
    private let queue: DispatchQueue
    private var value: V
    
    init(wrappedValue: V, queue: DispatchQueue) {
        self.queue = queue
        self.value = wrappedValue
    }
    
    var wrappedValue: V {
        get { queue.sync { return value } }
        set { queue.async(flags: .barrier) {
            self.value = newValue
        }}
    }
    
    func mutate(_ mutation: (inout V) -> Void) {
        return queue.sync {
            mutation(&value)
        }
    }
}
