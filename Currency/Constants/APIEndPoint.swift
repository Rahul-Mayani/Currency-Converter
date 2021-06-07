//
//  APIEndPoint.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import Foundation

public struct APIEndPoint {
    
    static let endPointURL = Environment.production.rawValue
    
    enum Environment:String {
        case develop = "localhost"
        case staging = "http://"
        case production = "http://api.currencylayer.com/"
    }
    
    private static let apiAccessKey = "e981adf36cf863dee9ffd25392601a00"
    private static let accessKeyParam = "?access_key=\(apiAccessKey)"
    
    struct Name {
        static let currencyExchangeRates = endPointURL + "live" + accessKeyParam
        static let allCurrency = endPointURL + "list" + accessKeyParam
    }
}
