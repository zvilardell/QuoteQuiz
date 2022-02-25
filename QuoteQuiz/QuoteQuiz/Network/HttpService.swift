//
//  HttpService.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 7/30/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//
import Foundation
import Combine

class HttpService {
    
    private let kanyeEndpoint = "https://api.kanye.rest"
    private let breakingBadEndpoint = "https://breaking-bad-quotes.herokuapp.com/v1/quotes"
    private let ronSwansonEndpoint = "https://ron-swanson-quotes.herokuapp.com/v2/quotes"
    
    private let session = URLSession(configuration: .default)
    
    static let shared = HttpService()
    private init() {}
    
    func getKanyeQuote() -> AnyPublisher<Quote?, Error> {
        return get(kanyeEndpoint)
            .decode(type: KanyeResponse.self, decoder: JSONDecoder())
            .tryMap { kanyeResponse in
                let quote = Quote(text: kanyeResponse.quote, quoteSource: .kanyeWest)
                return quote
            }
            .eraseToAnyPublisher()
    }
    
    func getBreakingBadQuote() -> AnyPublisher<Quote?, Error> {
        return get(breakingBadEndpoint)
            .decode(type: Array<BreakingBadResponse>.self, decoder: JSONDecoder())
            .tryMap { arrayResponse in
                guard let bbResponse = arrayResponse.first else { return nil }
                let quote = Quote(text: bbResponse.quote, author: bbResponse.author, quoteSource: .breakingBad)
                return quote
            }
            .eraseToAnyPublisher()
    }
    
    func getRonSwansonQuote() -> AnyPublisher<Quote?, Error> {
        return get(ronSwansonEndpoint)
            .decode(type: Array<String>.self, decoder: JSONDecoder())
            .tryMap { arrayResponse in
                guard let ronQuote = arrayResponse.first else { return nil }
                let quote = Quote(text: ronQuote, quoteSource: .ronSwanson)
                return quote
            }
            .eraseToAnyPublisher()
    }
    
    private func get(_ endpoint: String) -> AnyPublisher<Data, Error>  {
        guard let url = URL(string: endpoint) else {
            return Fail(error: NSError())
                  .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, _ in
                return data
            }
            .eraseToAnyPublisher()
    }
}
