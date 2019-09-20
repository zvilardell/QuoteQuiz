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
    private var quote: Quote?
    
    init(delegate: GameButtonsDelegate?) {
        self.delegate = delegate
        super.init(nibName: "GameButtonsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setQuote(_ quote: Quote) {
        self.quote = quote
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let quote = quote, let selectedSource = QuoteSource(rawValue: sender.tag) else { return }
        delegate?.answerSelected(withSource: selectedSource)
        navigationController?.pushViewController(ResultsViewController(quote: quote, selectedSource: selectedSource, delegate: delegate), animated: true)
    }
}
