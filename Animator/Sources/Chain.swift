//
//  Chain.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

class Chain: Chainable {
    weak var chain: Chain?
    let chainGroup = DispatchGroup()
    let chainOperationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    var chains: [Chainable] = []
    
    func perform(_ completion: @escaping () -> ()) {
        guard !chains.isEmpty else { return }
        let (enter, leave, wait) = ({ [weak self] () -> Void in self?.chainGroup.enter() },
                                    { [weak self] () -> Void in self?.chainGroup.leave() },
                                    { [weak self] () -> Void in self?.chainGroup.wait()  })
        chains.forEach { chain in chainOperationQueue.addOperation { enter(); chain.perform(leave); wait() } }
        chainOperationQueue.addOperation {
            _ = self
            completion()
        }
    }
}
