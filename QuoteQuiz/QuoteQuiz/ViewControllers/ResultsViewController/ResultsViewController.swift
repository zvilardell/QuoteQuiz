//
//  ResultsViewController.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 9/19/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ResultsViewController: UIViewController {

    @IBOutlet weak var answerResultsLabel: UILabel!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    private weak var delegate: GameButtonsDelegate?
    private let quote: Quote?
    private let selectedSource: QuoteSource
    private var notificationToken: RLMNotificationToken?
    
    private let favoritedImage: UIImage? = UIImage(systemName: "suit.heart.fill")
    private let notFavoritedImage: UIImage? = UIImage(systemName: "suit.heart")
    private let nextArrowImage: UIImage? = UIImage(systemName: "arrow.right")
    
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
        guard let arrowImage = nextArrowImage else { return }
        
        arrowImageView.setImage(arrowImage, withTintColor: .white)
        observeQuote()
    }
    
    private func observeQuote() {
        guard let realm = try? Realm(), let quote = self.quote else { return }
        
        //cannot observe unmanaged single objects
        //observe results collection instead, initially empty if quote has not been saved
        let results = realm.objects(Quote.self).filter("text == %@", quote.text)
        notificationToken = results.observe { [weak self] changes in
            switch changes {
            case .initial:
                let saved = quote.existsInRealm()
                guard let heartImage = saved ? self?.favoritedImage : self?.notFavoritedImage else { return }
                self?.heartImageView.setImage(heartImage, withTintColor: .white)
            case .update(_, let deletions, let insertions, let modifications):
                if !deletions.isEmpty {
                    //quote has been un-favorited
                    guard let heartImage = self?.notFavoritedImage else { return }
                    self?.heartImageView.setImage(heartImage, withTintColor: .white)
                } else if !insertions.isEmpty {
                    //quote has been favorited
                    guard let heartImage = self?.favoritedImage else { return }
                    self?.heartImageView.setImage(heartImage, withTintColor: .white)
                }
            case .error(let error):
                fatalError("\(error)")
            }
        }
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
        guard let quote = quote else { return }
        
        if !quote.existsInRealm() {
            quote.saveToRealm()
        } else {
            //quote.removeFromRealm()
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)//.popRightToLeft()
        delegate?.showNextQuote()
    }
    
}
