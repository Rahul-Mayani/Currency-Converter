//
//  UIAlertController+Extension.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import UIKit

extension UIAlertController {
    
    class private func getAlertController(title : String, message : String?) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message ?? AppMessages.blank, preferredStyle: (UIDevice.current.userInterfaceIdiom == .pad) ? .alert : .actionSheet)
        return alertController
    }
    
    class func showAlert(title : String? = nil, message : String? = AppMessages.blank, handler: ((UIAlertController) -> Void)? = nil){
        let alertController = getAlertController(title: title ?? AppMessages.blank, message: message)
        
        alertController.addAction(UIAlertAction(title: AppMessages.ok, style: .default, handler: { (action) in
            handler?(alertController)
        }))
        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
}
