//
//  Quote.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 9/18/19.
//  Copyright © 2019 zvilardell. All rights reserved.
//

import Foundation
import RealmSwift

enum QuoteSource: Int {
    case breakingBad = 0
    case ronSwanson = 1
    case kanyeWest = 2
}

class Quote: Object {
    
    @objc dynamic var text: String = ""
    @objc dynamic var author: String?
    @objc dynamic private var quoteSource: Int = -1
    
    var source: QuoteSource? {
        return QuoteSource(rawValue: self.quoteSource)
    }
    
    override class func primaryKey() -> String? {
        return "text"
    }
    
    convenience init(text: String, author: String? = nil, quoteSource: QuoteSource) {
        self.init()
        self.text = text
        self.author = author
        self.quoteSource = quoteSource.rawValue
    }
}

//MARK: - Realm Helper Methods
extension Quote {
    func existsInRealm() -> Bool {
        guard let realm = try? Realm() else { return false }
        return realm.object(ofType: Quote.self, forPrimaryKey: self.text) != nil
    }
    
    func saveToRealm() {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.add(self, update: .error)
        }
    }
    
    func removeFromRealm() {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.delete(self)
        }
    }
}
