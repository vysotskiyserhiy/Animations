//
//  Group.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

public class Group: Chainable {
    public weak var chain: Chain?
    public weak var group: Group?
    let workingGroup = DispatchGroup()
    public var chains: [Chainable] = []
    
    public func perform(_ completion: @escaping () -> ()) {
        chains.forEach { chain in
            workingGroup.enter()
            chain.perform(workingGroup.leave)
        }
        
        workingGroup.wait()
        completion()
    }
}
