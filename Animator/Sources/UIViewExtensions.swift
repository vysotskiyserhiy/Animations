//
//  UIViewExtensions.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit.UIView

extension UIView {
    @discardableResult
    public func animate(withDuration duration: TimeInterval, delay: TimeInterval, options: UIView.AnimationOptions = [], animations: @escaping (UIView) -> Void) -> Animation {
        return Animation({ [weak self] in self.map { animations($0) } }, config: Animation.Config(withDuration: duration, delay: delay, options: options))
    }
    
    @discardableResult
    public func animate(withDuration duration: TimeInterval, options: UIView.AnimationOptions = [], animations: @escaping (UIView) -> Void) -> Animation {
        return Animation({ [weak self] in self.map { animations($0) } }, config: Animation.Config(withDuration: duration))
    }
    
    @discardableResult
    public func animate(withDuration duration: TimeInterval, delay: TimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat, options: UIView.AnimationOptions = [], animations: @escaping (UIView) -> Void) -> Animation {
        return Animation({ [weak self] in self.map { animations($0) } }, config: Animation.Config(withDuration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity, options: options))
    }
}
