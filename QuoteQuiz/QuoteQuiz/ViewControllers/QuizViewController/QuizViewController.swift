//
//  QuizViewController.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 7/31/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quoteTextView: UITextView!
    
    private let quoteGenerator: RandomQuoteGenerator
    
    init(quoteGenerator: RandomQuoteGenerator = RandomQuoteGenerator()) {
        self.quoteGenerator = quoteGenerator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        quoteTextView.textContainerInset = .zero
        quoteTextView.contentInset = .zero
        quoteTextView.text = ""
        getQuote()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getQuote))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func getQuote() {
        quoteGenerator.generateQuote { [weak self] quote, source in
            DispatchQueue.main.async {
                self?.quoteTextView.setQuoteText(quote)
            }
        }
    }
}
