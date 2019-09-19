//
//  HttpService.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 7/30/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import Foundation
import Alamofire

class HttpService {
    
    private let kanyeEndpoint = "https://api.kanye.rest"
    private let breakingBadEndpoint = "https://breaking-bad-quotes.herokuapp.com/v1/quotes"
    private let ronSwansonEndpoint = "https://ron-swanson-quotes.herokuapp.com/v2/quotes"
    
    static let shared = HttpService()
    private init() {}
    
    func getKanyeQuote(completion: @escaping (Quote)->()) {
        get(kanyeEndpoint) { data in
            guard let kanyeResponse = try? JSONDecoder().decode(KanyeResponse.self, from: data) else { return }
            let quote = Quote(text: kanyeResponse.quote, quoteSource: .kanyeWest)
            completion(quote)
        }
    }
    
    func getBreakingBadQuote(completion: @escaping (Quote)->()) {
        get(breakingBadEndpoint) { data in
            guard let arrayResponse = try? JSONDecoder().decode(Array<BreakingBadResponse>.self, from: data), let bbResponse = arrayResponse.first else { return }
            let quote = Quote(text: bbResponse.quote, author: bbResponse.author, quoteSource: .breakingBad)
            completion(quote)
        }
    }
    
    func getRonSwansonQuote(completion: @escaping (Quote)->()) {
        get(ronSwansonEndpoint) { data in
            guard let arrayResponse = try? JSONDecoder().decode(Array<String>.self, from: data), let ronQuote = arrayResponse.first else { return }
            let quote = Quote(text: ronQuote, quoteSource: .ronSwanson)
            completion(quote)
        }
    }
    
    private func get(_ endpoint: String, completion: @escaping (Data)->()) {
        Alamofire.request(endpoint, method: .get).responseData { response in
            guard let responseData = response.data else { return }
            completion(responseData)
        }
    }
}
