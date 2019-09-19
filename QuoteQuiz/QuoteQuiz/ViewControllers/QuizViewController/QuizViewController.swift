//
//  QuizViewController.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 7/31/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit

protocol GameButtonsDelegate {
    func answerSelected(withSource source: QuoteSource)
}

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var gameButtonsView: UIView!
    
    private let quoteGenerator: RandomQuoteGenerator
    private var currentQuote: Quote?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //add game buttons as a child view controller
        addChildViewController(GameButtonsViewController(delegate: self), withFrame: gameButtonsView.frame)
    }
    
    private func setupView() {
        title = "QuoteQuiz"
        quoteTextView.textContainerInset = .zero
        quoteTextView.contentInset = .zero
        quoteTextView.text = ""
        getQuote()
    }
    
    @objc func getQuote() {
        quoteGenerator.generateQuote { [weak self] quote in
            DispatchQueue.main.async {
                self?.currentQuote = quote
                self?.quoteTextView.setQuoteText(quote.text)
            }
        }
    }
}

extension QuizViewController: GameButtonsDelegate {
    func answerSelected(withSource source: QuoteSource) {
        guard let currentQuote = self.currentQuote, let currentSource = currentQuote.source else { return }
        if currentSource == source {
            getQuote()
        } else {
            
        }
    }
}
