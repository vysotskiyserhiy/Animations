//
//  Animation.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/6/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

public class Animation: Chainable {
    public var chain: Chain?
    public var group: Group?
    
    let configuration: AnimationConfiguration
    let animations: () -> Void
    var performed = false
    
    init(_ animations: @escaping () -> Void, configuration: AnimationConfiguration) {
        self.animations = animations
        self.configuration = configuration
    }
    
    public func perform(_ completion: @escaping () -> () = {}) {
        performed = true
        UIView.animate(
            withDuration: configuration.duration,
            delay: configuration.delay,
            usingSpringWithDamping: configuration.damping,
            initialSpringVelocity: configuration.velocity,
            options: configuration.options,
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
