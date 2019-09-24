//
//  UIImageView+setTintColor.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 9/24/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(_ image: UIImage, withTintColor color: UIColor) {
        image.withRenderingMode(.alwaysTemplate)
        self.image = image
        self.tintColor = color
    }
}
