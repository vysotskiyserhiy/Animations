//
//  AnimationConfiguration.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/6/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

class AnimationConfiguration {
    private(set) var duration: TimeInterval = 0.3
    private(set) var delay: TimeInterval = 0
    private(set) var damping: CGFloat?
    private(set) var velocity: CGFloat?
    private(set) var options: UIView.AnimationOptions
    private(set) var completion: (() -> Void)?
    
    init(_ options: [AnimatorOptions]) {
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
            case let .complete(block):
                self.completion = block
            }
        }
        
        self.options = animationOptions
    }
}
