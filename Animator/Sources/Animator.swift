//
//  Animator.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

extension Animation {
    public class Config {
        public let duration: TimeInterval
        public let delay: TimeInterval
        public let damping: CGFloat
        public let velocity: CGFloat
        public let options: UIView.AnimationOptions
        public static let `default` = Config(withDuration: 1)
        
        public init(withDuration duration: TimeInterval, delay: TimeInterval = 0, usingSpringWithDamping dampingRatio: CGFloat = 1, initialSpringVelocity velocity: CGFloat = 0, options: UIView.AnimationOptions = []) {
            self.duration = duration
            self.delay = delay
            self.damping = dampingRatio
            self.velocity = velocity
            self.options = options
        }
    }
}

public class Animation: Chainable {
    public weak var chain: ChainsStorage?
    public let config: Config
    let animations: () -> Void
    var performed = false
    
    public init(_ animations: @escaping () -> Void, config: Config = .default) {
        self.animations = animations
        self.config = config
    }
    
    public func perform(_ completion: @escaping () -> () = {}) {
        performed = true
        UIView.animate(
            withDuration: config.duration,
            delay: config.delay,
            usingSpringWithDamping: config.damping,
            initialSpringVelocity: config.velocity,
            options: config.options,
            animations: animations,
            completion: { _ in completion() }
        )
    }
    
    deinit {
        if !performed {
            perform()
        }
    }
}

extension Animation {
    func then() {
        
    }
}
