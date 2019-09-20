//
//  ResultsViewController.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 9/19/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var answerResultsLabel: UILabel!
    
    private weak var delegate: GameButtonsDelegate?
    private let quote: Quote?
    private let selectedSource: QuoteSource
    
    init(quote: Quote?, selectedSource: QuoteSource, delegate: GameButtonsDelegate?) {
        self.quote = quote
        self.selectedSource = selectedSource
        self.delegate = delegate
        super.init(nibName: "ResultsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showResults()
    }
    
    private func showResults() {
        guard let quote = quote, let quoteSource = quote.source else { return }
        if quoteSource == selectedSource {
            answerResultsLabel.text = "Correct!"
            answerResultsLabel.textColor = .green
        } else {
            answerResultsLabel.text = "Incorrect."
            answerResultsLabel.textColor = .red
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        print("Favorite tapped")
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        navigationController?.popRightToLeft()
        delegate?.showNextQuote()
    }
    
}
