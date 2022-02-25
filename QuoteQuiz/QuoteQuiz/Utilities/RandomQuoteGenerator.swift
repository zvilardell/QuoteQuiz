//
//  RandomQuoteGenerator.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 7/31/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import Foundation
import Combine

class RandomQuoteGenerator {
    
    private let webService: HttpService
    
    init(webService: HttpService = .shared) {
        self.webService = webService
    }
    
    func generateQuote() -> AnyPublisher<Quote?, Error> {
        let randomNumber = Int.random(in: 0...2)
        guard let quoteSource = QuoteSource(rawValue: randomNumber) else {
            return Fail(error: NSError())
                .eraseToAnyPublisher()
        }
        switch quoteSource {
        case .breakingBad:
            return webService.getBreakingBadQuote()
        case .ronSwanson:
            return webService.getRonSwansonQuote()
        case .kanyeWest:
            return webService.getKanyeQuote()
        }
    }
}
