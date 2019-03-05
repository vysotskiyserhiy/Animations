//
//  Block.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

class Block: Chainable {
    let block: () -> Void
    weak var chain: ChainsStorage?
    
    init(_ block: @escaping () -> Void) {
        self.block = block
    }
    
    func perform(_ completion: @escaping () -> ()) {
        block()
        completion()
    }
}
