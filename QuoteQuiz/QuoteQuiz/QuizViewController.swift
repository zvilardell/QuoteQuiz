//
//  ViewController.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 7/30/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quoteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteTextView.textContainerInset = .zero
        quoteTextView.contentInset = .zero
        quoteTextView.text = ""
        getQuote()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getQuote))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func getQuote() {
        HttpService.shared.getRonSwansonQuote() { [weak self] quote in
            DispatchQueue.main.async {
                self?.quoteTextView.setQuoteText(quote)
            }
        }
    }
}
