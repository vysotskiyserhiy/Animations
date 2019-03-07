//
//  Block.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

public class Block: Chainable {
    let block: () -> Void
    public weak var chain: Chain?
    public weak var group: Group?
    
    public init(_ block: @escaping () -> Void) {
        self.block = block
    }
    
    public func perform(_ completion: @escaping () -> ()) {
        block()
        completion()
    }
}
