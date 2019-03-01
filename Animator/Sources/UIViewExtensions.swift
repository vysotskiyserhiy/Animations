//
//  UIViewExtensions.swift
//  Animator
//
//  Created by Serhiy Vysotskiy on 3/1/19.
//  Copyright © 2019 Serhiy Vysotskiy. All rights reserved.
//

import UIKit.UIView

extension UIView {
    func animate(_ block: @escaping (UIView) -> ()) -> Chainable {
        let animation = Animation({ [weak self] in
            guard let sSelf = self else { return }
            block(sSelf)
        })
        
        return animation
    }
}
