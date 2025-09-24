//
//  TransactionsModel.swift
//  FinanceTracker
//
//  Created by Collins Muthomi on 24/09/2025.
//

import Foundation



public struct TransactionsModel: Codable {
    public var id: String?
    public var date: String?
    public var baseCurrency: String?
    public var targetCurrency: String?
    public var rate: Double?
    public var source: String?
    public var status: String?
    
    public init(id: String? = nil, date: String? = nil, baseCurrency: String? = nil, targetCurrency: String? = nil, rate: Double? = nil, source: String? = nil, status: String? = nil) {
        self.id = id
        self.date = date
        self.baseCurrency = baseCurrency
        self.targetCurrency = targetCurrency
        self.rate = rate
        self.source = source
        self.status = status
    }
}
