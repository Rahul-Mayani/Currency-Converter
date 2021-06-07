//
//  Rx+Extension.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import RxCocoa
import RxSwift

// MARK: - Add to dispose bag shorthand

precedencegroup DisposablePrecedence {
    lowerThan: DefaultPrecedence
}

infix operator =>: DisposablePrecedence

public func =>(disposable: Disposable?, bag: DisposeBag?) {
    if let d = disposable, let b = bag {
        d.disposed(by: b)
    }
}
