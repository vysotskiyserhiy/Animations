//
//  Animation.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/6/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

public class Animation: Chainable {
    public var next: Chainable?
    public var current: Chainable?
    
    let configuration: AnimationConfiguration
    let animations: () -> Void
    let completion: (() -> Void)?
    var performed = false
    
    init(_ animations: @escaping () -> Void, configuration: AnimationConfiguration, completion: (() -> Void)?) {
        self.animations = animations
        self.completion = completion
        self.configuration = configuration
    }
    
    public func perform(_ completion: (() -> Void)?) {
        performed = true
        let localCompletion = self.completion
        UIView.animate(
            withDuration: configuration.duration,
            delay: configuration.delay,
            usingSpringWithDamping: configuration.damping,
            initialSpringVelocity: configuration.velocity,
            options: configuration.options,
            animations: animations,
            completion: { _ in completion?(); localCompletion?() }
        )
    }
    
    deinit {
        if !performed {
            activateChain()
        }
    }
}
