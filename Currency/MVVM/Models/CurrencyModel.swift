//
//  CurrencyModel.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import Foundation

// MARK: - all Currency List Model -
struct AllCurrencyModel {
    var success: Bool
    var terms: String
    var privacy: String
    var currencies: [String: String]
}

extension AllCurrencyModel: Codable {
    
    typealias CurrencyList = [String]
    
    func getAllCurrencyList() -> CurrencyList {
        return self.currencies.keys.map { $0 }.sorted()
    }
}


// MARK: - Currency Exchange Rates Model -
struct CurrencyRatesModel {
    var success: Bool
    var terms: String
    var privacy: String
    var timestamp: Int64
    var source: String
    var quotes: [String: Double]
}

struct CurrencyQuote {
    var name: String
    var value: Double
}

extension CurrencyRatesModel: Codable {
    
    typealias ExchangeRates = [CurrencyQuote]
    
    func getAllCurrencyRatesList() -> ExchangeRates {
        return self.quotes.keys.map { CurrencyQuote(name: $0, value: self.quotes[$0] ?? 0.0) }.sorted { $0.name < $1.name }
    }
}
