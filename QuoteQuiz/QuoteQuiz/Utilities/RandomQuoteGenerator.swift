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
    private var subscriptions: Set<AnyCancellable> = []
    
    init(webService: HttpService = .shared) {
        self.webService = webService
    }
    
    func generateQuote(completion: @escaping (Quote)->()) {
        let randomNumber = Int.random(in: 0...2)
        guard let quoteSource = QuoteSource(rawValue: randomNumber) else { return }
        switch quoteSource {
        case .breakingBad:
            webService.getBreakingBadQuote()
                .decode(type: Array<BreakingBadResponse>.self, decoder: JSONDecoder())
//                .first()
                .tryMap { arrayResponse in
                    guard let bbResponse = arrayResponse.first else { return }
                    let quote = Quote(text: bbResponse.quote, author: bbResponse.author, quoteSource: .breakingBad)
                    completion(quote)
                }
                .sink {
                    print("BB Completion: \($0)")
                } receiveValue: {
                    print("BB Value: \($0)")
                }
                .store(in: &subscriptions)

        case .ronSwanson:
            webService.getRonSwansonQuote()
                .decode(type: Array<String>.self, decoder: JSONDecoder())
//                .first()
                .tryMap { arrayResponse in
                    guard let ronQuote = arrayResponse.first else { return }
                    let quote = Quote(text: ronQuote, quoteSource: .ronSwanson)
                    completion(quote)
                }
                .sink {
                    print("Ron Completion: \($0)")
                } receiveValue: {
                    print("Ron Value: \($0)")
                }
                .store(in: &subscriptions)
            
        case .kanyeWest:
            webService.getKanyeQuote()
                .decode(type: KanyeResponse.self, decoder: JSONDecoder())
//                .first()
                .tryMap { kanyeResponse in
                    let quote = Quote(text: kanyeResponse.quote, quoteSource: .kanyeWest)
                    completion(quote)
                }
                .sink {
                    print("Kanye Completion: \($0)")
                } receiveValue: {
                    print("Kanye Value: \($0)")
                }
                .store(in: &subscriptions)
        }
    }
}
