//
//  Chain.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

public class Chain: Chainable {
    public weak var chain: Chain?
    public weak var group: Group?
    
    let chainGroup = DispatchGroup()
    let workingQueue = DispatchQueue(label: UUID().uuidString, qos: .utility, autoreleaseFrequency: .workItem)
    
    var performed = false
    
    lazy var chainOperationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.underlyingQueue = workingQueue
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    public var chains: [Chainable] = []
    
    var initTime = CFAbsoluteTimeGetCurrent()
    public init() {
        print("INIT CHAIN")
    }
    
    public func perform(_ completion: @escaping () -> () = {}) {
        guard !chains.isEmpty else { return }
        let (enter, leave, wait) = ({ [weak self] () -> Void in self?.chainGroup.enter() },
                                    { [weak self] () -> Void in self?.chainGroup.leave() },
                                    { [weak self] () -> Void in self?.chainGroup.wait()  })
        
        let operationQueue = chainOperationQueue
        chains.forEach { chain in
            operationQueue.addOperation {
                enter()
                
                DispatchQueue.main.async {
                    chain.perform(leave)
                }
                
                wait()
            }
        }
        
        operationQueue.addOperation {
            _ = operationQueue
            _ = self
            completion()
        }
    }
    
    deinit {
        print("DEINIT CHAIN", CFAbsoluteTimeGetCurrent() - initTime)
        if !performed {
            perform()
        }
    }
}
