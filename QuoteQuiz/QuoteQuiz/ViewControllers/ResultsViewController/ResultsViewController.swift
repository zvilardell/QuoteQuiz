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
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var arrowImageView: UIImageView!
    
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
        setupView()
        showResults()
    }
    
    private func setupView() {
        guard let quote = self.quote,
              let arrowImage = UIImage(named: "NextArrow"),
              let heartImage = quote.existsInRealm() ? UIImage(named: "FavoritedHeart") : UIImage(named: "UnfavoritedHeart")
              else { return }
        
        arrowImageView.setImage(arrowImage, withTintColor: .white)
        heartImageView.setImage(heartImage, withTintColor: .white)
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
        guard let quote = quote,
              let newHeartImage = !quote.existsInRealm() ? UIImage(named: "FavoritedHeart") : UIImage(named: "UnfavoritedHeart")
              else { return }
        if !quote.existsInRealm() {
            quote.saveToRealm()
            heartImageView.setImage(newHeartImage, withTintColor: .white)
        } else {
            print("unfavorite quote")
            heartImageView.setImage(newHeartImage, withTintColor: .white)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)//.popRightToLeft()
        delegate?.showNextQuote()
    }
    
}
