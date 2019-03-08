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
    public var next: Chainable?
    public var current: Chainable?
    
    public init(_ block: @escaping () -> Void) {
        self.block = block
    }
    
    public func perform(_ completion: (() -> Void)?) {
        block()
        completion?()
    }
}
