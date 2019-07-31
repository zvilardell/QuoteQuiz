//
//  ResponseModels.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 7/30/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import Foundation

struct KanyeResponse: Codable {
    let quote: String
}

struct BreakingBadResponse: Codable {
    let quote: String
    let author: String
}
