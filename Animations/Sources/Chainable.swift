//
//  Chainable.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

public protocol Chainable: class {
    var next: Chainable? { set get }
    var current: Chainable? { set get }
    func perform(_ completion: (() -> Void)?)
}

extension Chainable {
    public func activateChain() {
        var current = self.current
        let next = self.next
        
        let group = DispatchGroup()
        let queue = DispatchQueue(label: UUID().uuidString)
        
        group.enter()
        perform {
            group.leave()
        }
        
        while current != nil {
            group.enter()
            current?.perform(group.leave)
            current = current?.current
        }
        
        queue.async {
            group.wait()
            DispatchQueue.main.async {
                next?.activateChain()
            }
        }
    }
}

infix operator <<<: AdditionPrecedence
public extension Chainable {
    @discardableResult
    func chain(_ chain: Self) -> Self {
        next = chain
        return chain
    }
    
    @discardableResult
    static func <<< (_ l: Self, r: Self) -> Self {
        return l.chain(r)
    }
}

