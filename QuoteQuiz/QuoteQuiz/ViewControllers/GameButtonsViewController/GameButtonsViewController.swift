//
//  GameButtonsViewController.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 9/18/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import UIKit

class GameButtonsViewController: UIViewController {
    
    private let delegate: GameButtonsDelegate
    
    init(delegate: GameButtonsDelegate) {
        self.delegate = delegate
        super.init(nibName: "GameButtonsViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Button Actions
extension GameButtonsViewController {
    
    @IBAction func breakingBadButtonTapped(_ sender: Any) {
        delegate.answerSelected(withSource: .breakingBad)
    }
    
    @IBAction func ronSwansonButtonTapped(_ sender: Any) {
        delegate.answerSelected(withSource: .ronSwanson)
    }
    
    @IBAction func kanyeWestButtonTapped(_ sender: Any) {
        delegate.answerSelected(withSource: .kanyeWest)
    }
}
