//
//  QuizViewController.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 7/31/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit
import SwiftUI

protocol GameButtonsDelegate: class {
    func answerSelected(withSource source: QuoteSource)
    func showNextQuote()
}

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var quoteTextViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var gameButtonsView: UIView!
    @IBOutlet weak var quoteSourceLabel: UILabel!
    
    private let quoteGenerator: RandomQuoteGenerator
    private var currentQuote: Quote?
    private lazy var gameButtonsViewController: GameButtonsViewController = GameButtonsViewController(delegate: self)
    
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
        getQuote()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //add game buttons as a child view controller
        let gameButtons = UIHostingController(rootView: GameButtonsView())
        addChildViewController(gameButtons, withFrame: gameButtonsView.frame)
    }
    
    private func setupView() {
        title = "QuoteQuiz"
        quoteTextView.textContainerInset = .zero
        quoteTextView.contentInset = .zero
        quoteTextView.isScrollEnabled = false
        quoteTextView.isSelectable = false
        quoteTextView.isEditable = false
        quoteTextView.text = ""
        quoteSourceLabel.isHidden = true
    }
    
    private func getQuote() {
        quoteGenerator.generateQuote { [unowned self] quote in
            DispatchQueue.main.async {
                self.quoteSourceLabel.isHidden = true
                self.currentQuote = quote
                self.gameButtonsViewController.setQuote(quote)
                self.quoteTextView.setQuoteText(quote.text, heightToAdjust: self.quoteTextViewHeightContraint)
            }
        }
    }
}

// MARK: - GameButtonsDelegate
extension QuizViewController: GameButtonsDelegate {
    
    func answerSelected(withSource source: QuoteSource) {
        guard let quote = self.currentQuote, let source = quote.source else { return }
        var quoteSourceText = "- "
        
        switch source {
        case .breakingBad:
            quoteSourceText += "Breaking Bad"
            if let author = quote.author {
                quoteSourceText += "\n  (\(author))"
            }
        case .ronSwanson:
            quoteSourceText += "Ron Swanson"
        case .kanyeWest:
            quoteSourceText += "Kanye West"
        }
        
        quoteSourceLabel.text = quoteSourceText
        quoteSourceLabel.isHidden = false
    }
    
    func showNextQuote() {
        getQuote()
    }
}
