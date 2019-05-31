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
