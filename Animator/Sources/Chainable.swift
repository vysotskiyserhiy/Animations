//
//  Chainable.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import Foundation

public protocol ChainsStorage: class {
    var chains: [Chainable] { get set }
}

public protocol Chainable {
    var chain: ChainsStorage? { get }
    func perform(_ completion: @escaping () -> ())
}

