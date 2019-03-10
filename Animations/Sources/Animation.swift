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
        
        let onComplete: (Bool) -> Void = { _ in completion?(); localCompletion?() }
        
        if configuration.damping != nil || configuration.velocity != nil {
            UIView.animate(
                withDuration: configuration.duration,
                delay: configuration.delay,
                usingSpringWithDamping: configuration.damping ?? 1,
                initialSpringVelocity: configuration.velocity ?? 0,
                options: configuration.options,
                animations: animations,
                completion: onComplete
            )
        } else {
            UIView.animate(
                withDuration: configuration.duration,
                delay: configuration.delay,
                options: configuration.options,
                animations: animations,
                completion: onComplete
            )
        }
    }
    
    deinit {
        if !performed && true {
            activateChain()
        }
    }
}
