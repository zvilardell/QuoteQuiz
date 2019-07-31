//
//  UITextView+setQuoteText.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 7/30/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit

extension UITextView {
    func setQuoteText(_ text: String) {
        self.text = "\"\(text)\""
    }
}
