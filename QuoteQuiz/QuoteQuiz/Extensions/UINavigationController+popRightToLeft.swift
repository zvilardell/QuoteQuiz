//
//  UINavigationController+popRightToLeft.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 9/19/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit

extension UINavigationController {
    func popRightToLeft() {
        let transition = CATransition()
        transition.duration = 0.45
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.layer.add(transition, forKey: kCATransition)
        popViewController(animated: true)
    }
}
