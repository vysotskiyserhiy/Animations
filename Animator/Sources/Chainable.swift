//
//  Chainable.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

protocol Chainable {
    var chain: Chain? { get }
    func perform(_ completion: @escaping () -> ())
}

extension Chainable {
    
}
