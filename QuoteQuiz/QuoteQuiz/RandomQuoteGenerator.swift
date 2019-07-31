//
//  RandomQuoteGenerator.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 7/31/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import Foundation

enum QuoteSource: Int {
    case breakingBad = 0
    case ronSwanson = 1
    case kanyeWest = 2
}

class RandomQuoteGenerator {
    
    private let webService: HttpService
    
    init(webService: HttpService = .shared) {
        self.webService = webService
    }
    
    func generateQuote(completion: @escaping (String, QuoteSource)->()) {
        let randomNumber = Int.random(in: 0...2)
        guard let quoteSource = QuoteSource(rawValue: randomNumber) else { return }
        switch quoteSource {
        case .breakingBad:
            webService.getBreakingBadQuote(completion: completion)
        case .ronSwanson:
            webService.getRonSwansonQuote(completion: completion)
        case .kanyeWest:
            webService.getKanyeQuote(completion: completion)
        }
    }
}