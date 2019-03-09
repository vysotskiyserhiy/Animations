//
//  UIViewExtensions.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit.UIView

extension UIAppearance where Self: UIView {
    @discardableResult
    public func animate(_ options: AnimatorOptions..., animations: @escaping (Self) -> Void, completion: (() -> Void)? = nil) -> Animation {
        let animationsBlock = { [weak self] () -> Void in self.map { animations($0) } }
        let options = AnimationConfiguration(options)
        return Animation(animationsBlock, configuration: options, completion: completion)
    }
}
