//
//  AnimationOptions.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/6/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

public enum AnimatorOptions {
    case duration(TimeInterval)
    case delay(TimeInterval)
    case damping(CGFloat)
    case velocity(CGFloat)
    case options(UIView.AnimationOptions)
    case complete(() -> Void)
}


