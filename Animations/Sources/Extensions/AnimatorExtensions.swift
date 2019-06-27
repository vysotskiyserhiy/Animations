//
//  UIKitExtensions.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

public extension Animator {
    @discardableResult
    func animate(_ options: AnimatorOptions..., animations: @escaping (Self) -> Void) -> Animation {
        return animate(options: options, animations: animations, completion: nil)
    }
    
    @discardableResult
    func animate(_ options: AnimatorOptions..., animations: @escaping (Self) -> Void, completion: @escaping (Self) -> Void) -> Animation {
        return animate(options: options, animations: animations, completion: completion)
    }
    
    @discardableResult
    func animate(options: [AnimatorOptions], animations: @escaping (Self) -> Void, completion: ((Self) -> Void)?) -> Animation {
        let animationsBlock = { [weak self] () -> Void in self.map { animations($0) } }
        let completionBlock = { [weak self] () -> Void in self.map { completion?($0) } }
        let options = AnimationConfiguration(options)
        return Animation(animationsBlock, configuration: options, completion: completionBlock)
    }
}

public extension Animator where Self: UIView {
    @discardableResult
    func animate(_ options: AnimatorOptions..., animate common: CommonAnimations) -> Animation {
        return animate(options, animate: common, completion: nil)
    }
    
    @discardableResult
    func animate(_ options: AnimatorOptions..., animate common: CommonAnimations, completion: @escaping (Self) -> Void) -> Animation {
        return animate(options, animate: common, completion: completion)
    }
    
    @discardableResult
    func animate(_ options: [AnimatorOptions], animate common: CommonAnimations, completion: ((Self) -> Void)? = nil) -> Animation {
        return animate(options: options, animations: common.animationBlock, completion: completion)
    }
}
