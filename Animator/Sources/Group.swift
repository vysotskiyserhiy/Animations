//
//  Group.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

public class Group: Chainable, ChainsStorage {
    public weak var chain: ChainsStorage?
    let group = DispatchGroup()
    public var chains: [Chainable] = []
    
    public func perform(_ completion: @escaping () -> ()) {
        chains.forEach { chain in group.enter(); chain.perform(group.leave) }
        group.wait()
        completion()
    }
}
