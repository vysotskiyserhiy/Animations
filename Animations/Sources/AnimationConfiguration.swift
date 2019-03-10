//
//  AnimationConfiguration.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/6/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

class AnimationConfiguration {
    private(set) var duration: TimeInterval
    private(set) var delay: TimeInterval
    private(set) var damping: CGFloat?
    private(set) var velocity: CGFloat?
    private(set) var options: UIView.AnimationOptions
    static let `default` = AnimationConfiguration(withDuration: 0.3)
    
    init(withDuration duration: TimeInterval, delay: TimeInterval = 0, usingSpringWithDamping dampingRatio: CGFloat? = nil, initialSpringVelocity velocity: CGFloat? = nil, options: UIView.AnimationOptions = []) {
        self.duration = duration
        self.delay = delay
        self.damping = dampingRatio
        self.velocity = velocity
        self.options = options
    }
    
    convenience init(_ options: [AnimatorOptions]) {
        self.init(withDuration: 0)
        
        var animationOptions: UIView.AnimationOptions = []
        
        for option in options {
            switch option {
            case let .duration(duration):
                self.duration = duration
            case let .delay(delay):
                self.delay = delay
            case let .damping(damping):
                self.damping = damping
            case let .velocity(velocity):
                self.velocity = velocity
            case let .options(options):
                animationOptions.formUnion(options)
            }
        }
        
        self.options = animationOptions
    }
}
