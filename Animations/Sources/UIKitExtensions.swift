//
//  UIKitExtensions.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

public protocol Animator: class {}

extension UIView: Animator {}
extension UIViewController: Animator {}

public extension Animator {
    @discardableResult
    func animate(_ options: AnimatorOptions..., animations: @escaping (Self) -> Void, completion: ((Self) -> Void)? = nil) -> Animation {
        return animate(options: options, animations: animations, completion: completion)
    }
    
    @discardableResult
    func animate(options: [AnimatorOptions], animations: @escaping (Self) -> Void, completion: ((Self) -> Void)? = nil) -> Animation {
        let animationsBlock = { [weak self] () -> Void in self.map { animations($0) } }
        let completionBlock = { [weak self] () -> Void in self.map { completion?($0) } }
        let options = AnimationConfiguration(options)
        return Animation(animationsBlock, configuration: options, completion: completionBlock)
    }
}

public extension Animator where Self: UIView {
    @discardableResult
    func animate(_ options: AnimatorOptions..., animation: CommonAnimations, completion: ((Self) -> Void)? = nil) -> Animation {
        return animate(options: options, animations: { (view) in
            switch animation {
            case let .transform(transform):
                view.transform = transform
            case let .alpha(alpha):
                view.alpha = alpha
            case let .frame(frame):
                view.frame = frame
            case let .size(size):
                view.frame.size = size
            case let .origin(origin):
                view.frame.origin = origin
            case let .center(center):
                view.center = center
            case let .color(color):
                view.backgroundColor = color
            }
        }, completion: completion)
    }
}
