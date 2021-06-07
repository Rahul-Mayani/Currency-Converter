//
//  General+Extensions.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import UIKit

extension CGRect {
    
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}

extension UIApplication {
    class func topViewController(base: UIViewController? = nil) -> UIViewController? {
        var baseVC = base
        if baseVC == nil {
            baseVC = appDelegate.window?.rootViewController
        }
        if let nav = baseVC as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = baseVC as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = baseVC?.presentedViewController {
            return topViewController(base: presented)
        }
        return baseVC
    }
}

extension String {
    
    func isEmpty() -> Bool{
        return self.trim().count == 0
    }

    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func isValidName() -> Bool {
        if self.trim().count > 0 {
            return true
        }
        return false
    }
    
    func currencyInputFormatting() -> String {

        var number: NSNumber!
        let formatter = NumberFormatter.getCurrencyFormatter()

        var amountWithPrefix = self

        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")

        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }

        return formatter.string(from: number)!
    }
}

extension NumberFormatter {
    class func getCurrencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 5
        formatter.minimumFractionDigits = 0
        formatter.currencySymbol = ""
        return formatter
    }
}
 
extension Double{
    
    func currencyAmount() -> String {
        let formatter = NumberFormatter.getCurrencyFormatter()
        if let formattedTipAmount = formatter.string(from: NSNumber(value: self)) {
            return "\(formattedTipAmount.trim())"
        }
        return "0"
    }
    
    func timeStampFormatter(_ formatter: String) -> String {
        
        let date = Date(timeIntervalSince1970: self)
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale.current
        dateFormater.dateFormat = formatter
        dateFormater.amSymbol = "am"
        dateFormater.pmSymbol = "pm"
        return dateFormater.string(from: date)
    }
}
