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
    
    func getKanyeQuote() -> AnyPublisher<Data, Error> {
        return get(kanyeEndpoint)
//        { data in
//            guard let kanyeResponse = try? JSONDecoder().decode(KanyeResponse.self, from: data) else { return }
//            let quote = Quote(text: kanyeResponse.quote, quoteSource: .kanyeWest)
//            completion(quote)
//        }
    }
    
    func getBreakingBadQuote() -> AnyPublisher<Data, Error> {
        return get(breakingBadEndpoint)
//        { data in
//            guard let arrayResponse = try? JSONDecoder().decode(Array<BreakingBadResponse>.self, from: data), let bbResponse = arrayResponse.first else { return }
//            let quote = Quote(text: bbResponse.quote, author: bbResponse.author, quoteSource: .breakingBad)
//            completion(quote)
//        }
    }
    
    func getRonSwansonQuote() -> AnyPublisher<Data, Error> {
        return get(ronSwansonEndpoint)
//        { data in
//            guard let arrayResponse = try? JSONDecoder().decode(Array<String>.self, from: data), let ronQuote = arrayResponse.first else { return }
//            let quote = Quote(text: ronQuote, quoteSource: .ronSwanson)
//            completion(quote)
//        }
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
        
//        let task = session.dataTask(with: request) { (data, response, error) in
//            guard let responseData = data else { return }
//            completion(responseData)
//        }
//
//        task.resume()
    }
}
