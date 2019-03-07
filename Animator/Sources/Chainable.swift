//
//  Chainable.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

public protocol Chainable: class {
    var chain: Chain? { set get }
    var group: Group? { set get }
    func perform(_ completion: @escaping () -> ())
}

extension Chainable {
    public func chain(with chainable: Chainable?) -> Chainable {
        let isChainableGiven = chainable != nil
        let chainableUnwrapped = chainable ?? self
        
        if let chain = chain {
            chain.chains.append(chainableUnwrapped)
        } else {
            chain = Chain()
            
            if isChainableGiven {
                chain!.chains.append(self)
            }
            
            chain!.chains.append(chainableUnwrapped)
        }
        
        return chainableUnwrapped
    }
    
    public func group(with chainable: Chainable?) -> Chainable {
        let isChainableGiven = chainable != nil
        let chainableUnwrapped = chainable ?? self
        
        if let group = group {
            group.chains.append(chainableUnwrapped)
        } else {
            group = Group()
            
            if isChainableGiven {
                group!.chains.append(self)
            }
            
            group!.chains.append(chainableUnwrapped)
        }
        
        return chainableUnwrapped
    }
}

extension Chainable {
    public static func +(_ l: Chainable, r: Chainable) -> Chainable {
        return l.chain(with: r)
    }
    
    public static func +=(_ l: Chainable, r: Chainable) -> Chainable {
        return l.group(with: r)
    }
}
