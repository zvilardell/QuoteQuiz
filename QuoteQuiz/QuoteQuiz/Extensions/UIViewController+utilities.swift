//
//  UIViewController+utilities.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 8/30/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChildViewController(_ child: UIViewController, withFrame frame: CGRect) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = frame
        //child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.didMove(toParent: self)
    }
    
    func removeChildViewController(_ child: UIViewController) {
        guard child.parent != nil else { return }
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
