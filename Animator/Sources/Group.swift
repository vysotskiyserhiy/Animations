//
//  Group.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

class Group: Chainable {
    weak var chain: Chain?
    let group = DispatchGroup()
    var chains: [Chainable] = []
    
    func perform(_ completion: @escaping () -> ()) {
        chains.forEach { chain in group.enter(); chain.perform(group.leave) }
        group.wait()
        completion()
    }
}
