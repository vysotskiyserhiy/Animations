//
//  CommonAnimations.swift
//  Animations
//
//  Created by Serhiy Vysotskiy on 5/29/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

public enum CommonAnimations {
    case transform(CGAffineTransform)
    case alpha(CGFloat)
    case frame(CGRect)
    case size(CGSize)
    case origin(CGPoint)
    case center(CGPoint)
    case color(UIColor)
    case layoutIfNeeded
}

extension CommonAnimations {
    var animationBlock: (UIView) -> Void {
        let common = self
        return { (view) in
            switch common {
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
            case .layoutIfNeeded:
                view.superview?.layoutIfNeeded()
            }
        }
    }
}
