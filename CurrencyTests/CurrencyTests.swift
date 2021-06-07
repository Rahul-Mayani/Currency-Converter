//
//  CurrencyTests.swift
//  CurrencyTests
//
//  Created by Rahul Mayani on 31/05/21.
//

import XCTest
import RxSwift
import RxCocoa

@testable import Currency

class CurrencyTests: XCTestCase {

    // MARK: - Variable -
    private let rxbag = DisposeBag()
    private let currencyVM = CurrencyVM()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        /// interval every 1 minute and stop after 5 tasks are completed
        Observable<Int>.interval(.seconds(60), scheduler: MainScheduler.instance)
            .take(while: { value -> Bool in
                value < 5
            })
            .subscribe(onNext: { value in
                print(value)
            }) => rxbag
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: - Test Case -
    func testDataFechingFromServer() {
        
        // get data from server
        currencyVM.getDataFromServer()
        
        // data response handling by rxswift
        currencyVM.currencyExchangeRatesArray.subscribe(onNext: { (data) in
            XCTAssertTrue(!data.isEmpty)
        }) => rxbag
    }
    
    func testCurrencyQuoteNotWrong() throws {
        /// based on 1 USD rate
        let fromCurrency = CurrencyQuote(name: "INR", value: 72)
        currencyVM.selectedCurrency = fromCurrency
        
        /// AED test
        let toCurrency = CurrencyQuote(name: "AED", value: 3.7)
        let data = currencyVM.currencyQuote(toCurrency, amount: 12, currency: fromCurrency.name)

        let value =  try XCTUnwrap(data.value.isZero)
        XCTAssertFalse(value)
        
        XCTAssertEqual(Double(round(100*data.value)/100), 0.62)
        
        // AMD test
        let toCurrency1 = CurrencyQuote(name: "AMD", value: 520.21)
        let data1 = currencyVM.currencyQuote(toCurrency1, amount: 12, currency: fromCurrency.name)

        let value1 =  try XCTUnwrap(data1.value.isZero)
        XCTAssertFalse(value1)
       
        XCTAssertEqual(Double(round(100*data1.value)/100), 86.70)
        
        // USD test
        let toCurrency2 = CurrencyQuote(name: "USD", value: 1)
        let data2 = currencyVM.currencyQuote(toCurrency2, amount: 12, currency: fromCurrency.name)

        let value2 =  try XCTUnwrap(data2.value.isZero)
        XCTAssertFalse(value2)
       
        XCTAssertEqual(Double(round(100*data2.value)/100), 0.17)
    }
}
