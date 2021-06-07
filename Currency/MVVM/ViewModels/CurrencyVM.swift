//
//  CurrencyVM.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import UIKit
import RRAlamofireRxAPI
import RxCocoa
import RxSwift

class CurrencyVM {
    
    // MARK: - Variable -
    public var allCurrencyArray: AllCurrencyModel.CurrencyList = []
    // listing data array observe by rxswift
    public var currencyExchangeRatesArray: BehaviorRelay<CurrencyRatesModel.ExchangeRates> = BehaviorRelay(value: [])
        
    public var selectedCurrency: CurrencyQuote? = nil
    
    private let disposeBag = DisposeBag()
                
    // MARK: - Init -
    init() {
        /// Get Currency Exchange Rates every 30 minutes
        Observable<Int>.interval(.seconds(1800), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (value) in
                self?.getDataFromServer()
            }) => disposeBag
    }
}

// MARK: - Currency Exchange Rate -
extension CurrencyVM {
    
    public func refreshExchangeRate(currency: String = defaultCurrency) {
        selectedCurrency = currencyExchangeRatesArray.value.filter { $0.name ==  defaultCurrency + currency }.first
        currencyExchangeRatesArray.accept(currencyExchangeRatesArray.value)
    }
    
    public func currencyQuote(_ data: CurrencyQuote, amount: Double = defaultAmount, currency: String = defaultCurrency) -> CurrencyQuote {
        var name = data.name.replacingOccurrences(of: defaultCurrency, with: "")
        let originalAmount = data.value
        var convertedAmount = 0.0
        if amount == 0.0 { /// default rate
            convertedAmount = originalAmount
        } else if currency == defaultCurrency { /// converted rate
            convertedAmount = amount * originalAmount
        } else { /// converted rate
            let value = originalAmount / (selectedCurrency?.value ?? 0.0)
            convertedAmount = amount * value
        }
        if name.isEmpty {
            name = defaultCurrency
        }
        return CurrencyQuote(name: name, value: convertedAmount)
    }
}

// MARK: - API -
extension CurrencyVM {
    // get data from server by rxswift with alamofire
    public func getDataFromServer(_ isLoading: Bool = false, isGetAllCurrency: Bool = false) {
        
        if isLoading {
            AppLoader.startLoaderToAnimating()
        }
                
        let allCurrency = isGetAllCurrency ? RRAPIRxManager.shared.setURL(APIEndPoint.Name.allCurrency).setDeferredAsObservable() : Observable<Any>.just(isGetAllCurrency)
        
        allCurrency
            .flatMap { [weak self] (response) -> Observable<Any> in
                if isGetAllCurrency, let data = AllCurrencyModel.decodeJsonData(response) {
                    self?.allCurrencyArray = data.getAllCurrencyList()
                }
                return RRAPIRxManager.shared.setURL(APIEndPoint.Name.currencyExchangeRates)
                        .delaySubscribeConcurrentBackgroundToMainThreads(.seconds(2))
                        .setDeferredAsObservable()
            }
            .subscribeConcurrentBackgroundToMainThreads()
            .subscribe(onNext: { [weak self] (response) in
                let data = CurrencyRatesModel.decodeJsonData(response)
                self?.currencyExchangeRatesArray.accept(data?.getAllCurrencyRatesList() ?? [])
                AppLoader.stopLoaderToAnimating()
            }, onError: { (error) in
                UIAlertController.showAlert(message: error.localizedDescription)
                AppLoader.stopLoaderToAnimating()
            }) => disposeBag
    }
}
