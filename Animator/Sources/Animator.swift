//
//  Animator.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

extension Animation {
    struct Config {
        let duration: TimeInterval
        let delay: TimeInterval
        let damping: CGFloat
        let velocity: CGFloat
        let options: UIView.AnimationOptions
        static let `default` = Config(duration: 0.3, delay: 0, damping: 0, velocity: 0, options: [])
    }
}

struct Animation: Chainable {
    weak var chain: Chain?
    let animations: () -> Void
    let config: Config
    
    init(_ animations: @escaping () -> Void, config: Config = .default) {
        self.animations = animations
        self.config = config
    }
    
    func perform(_ completion: @escaping () -> ()) {
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
}
