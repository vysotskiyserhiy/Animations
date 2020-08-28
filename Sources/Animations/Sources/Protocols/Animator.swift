//
//  Animator.swift
//  Animations
//
//  Created by Serhiy Vysotskiy on 27.06.2019.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit

public protocol Animator: class {}

extension UIView: Animator {}
extension UIViewController: Animator {}
