//
//  ExchangeRatesModel.swift
//  FinanceTracker
//
//  Created by Collins Muthomi on 24/09/2025.
//

import Foundation

public struct ExchangeRatesModel: Codable {
   public var base: String?
    public var date: String?
    public var pairs: [CurrencyPair]?
    
    public init(base: String? = nil, date: String? = nil, pairs: [CurrencyPair]? = nil) {
        self.base = base
        self.date = date
        self.pairs = pairs
    }
}

public struct CurrencyPair: Codable {
    public var pair: String?
    public var rate: Double?
    
    public init(pair: String? = nil, rate: Double? = nil) {
        self.pair = pair
        self.rate = rate
    }
}
