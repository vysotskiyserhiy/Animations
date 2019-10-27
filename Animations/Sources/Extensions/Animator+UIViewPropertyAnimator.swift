//
//  Animator+UIViewPropertyAnimator.swift
//  Animations
//
//  Created by Serhiy Vysotskiy on 27.06.2019.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

public enum PropertyAnimatorTiming {
    case curve(UIView.AnimationCurve)
    case cubic(CGPoint, CGPoint)
    case provider(UITimingCurveProvider)
    case damping(CGFloat)
}

public extension Animator {
    func animator(duration: TimeInterval, timing: PropertyAnimatorTiming) -> UIViewPropertyAnimator {
        switch timing {
        case let .curve(curve):
            return UIViewPropertyAnimator(duration: duration, curve: curve, animations: nil)
        case let .cubic(c1, c2):
            return UIViewPropertyAnimator(duration: duration, controlPoint1: c1, controlPoint2: c2, animations: nil)
        case let .provider(provider):
            return UIViewPropertyAnimator(duration: duration, timingParameters: provider)
        case let .damping(damping):
            return UIViewPropertyAnimator(duration: duration, dampingRatio: damping, animations: nil)
        }
    }
    
    func animator(duration: TimeInterval, timing: PropertyAnimatorTiming, animations: @escaping (Self) -> Void) -> UIViewPropertyAnimator {
        return animator(duration: duration, timing: timing).addingAnimations { [weak self] in self.map { animations($0) } }
    }
    
    func animator(duration: TimeInterval, timing: PropertyAnimatorTiming, animations: @escaping (Self) -> Void, completion: @escaping (Self, UIViewAnimatingPosition) -> Void) -> UIViewPropertyAnimator {
        return animator(duration: duration, timing: timing)
            .addingAnimations { [weak self] in self.map { animations($0) } }
            .addingCompletion { [weak self] (position) in self.map { completion($0, position) } }
    }
}

public extension Animator where Self: UIView {
    func animator(duration: TimeInterval, timing: PropertyAnimatorTiming, animate commons: CommonAnimations...) -> UIViewPropertyAnimator {
        return animator(duration: duration, timing: timing, animations: { view in commons.forEach { $0.animationBlock(view) } })
    }
    
    func animator(duration: TimeInterval, timing: PropertyAnimatorTiming, animate commons: CommonAnimations..., completion: @escaping (Self, UIViewAnimatingPosition) -> Void) -> UIViewPropertyAnimator {
        return animator(duration: duration, timing: timing, animations: { view in commons.forEach { $0.animationBlock(view) } }, completion: completion)
    }
}

public extension UIViewPropertyAnimator {
    func addingAnimations(_ animations: @escaping () -> Void) -> Self {
        addAnimations(animations)
        return self
    }
    
    func addingCompletion(_ completion: @escaping (UIViewAnimatingPosition) -> Void) -> Self {
        addCompletion(completion)
        return self
    }
}
