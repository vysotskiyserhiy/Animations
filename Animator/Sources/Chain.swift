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
    
    lazy var chainOperationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.underlyingQueue = workingQueue
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    public var chains: [Chainable] = []
    public init() {}
    
    public func perform(_ completion: @escaping () -> ()) {
        guard !chains.isEmpty else { return }
        let (enter, leave, wait) = ({ [weak self] () -> Void in self?.chainGroup.enter() },
                                    { [weak self] () -> Void in self?.chainGroup.leave() },
                                    { [weak self] () -> Void in self?.chainGroup.wait()  })
        chains.forEach { chain in
            chainOperationQueue.addOperation {
                enter()
                
                DispatchQueue.main.async {
                    chain.perform(leave)
                }
                
                wait()
            }
        }
        
        chainOperationQueue.addOperation {
            _ = self
            completion()
        }
    }
}
