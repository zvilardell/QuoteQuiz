//
//  GameButtonsViewController.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 9/18/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit

class GameButtonsViewController: UIViewController {
    
    private weak var delegate: GameButtonsDelegate?
    private let quote: Quote?
    
    init(quote: Quote?, delegate: GameButtonsDelegate?) {
        self.quote = quote
        self.delegate = delegate
        super.init(nibName: "GameButtonsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let quoteSource = QuoteSource(rawValue: sender.tag) else { return }
        delegate?.answerSelected(withSource: quoteSource)
        navigationController?.pushViewController(ResultsViewController(quote: quote, selectedSource: quoteSource, delegate: delegate), animated: true)
    }
}
