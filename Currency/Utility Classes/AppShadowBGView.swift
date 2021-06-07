//
//  AppShadowBGView.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import UIKit

class AppShadowBGView: UIView {

    // MARK: - IBOutlet -
    
    // MARK: - Variable -
    
    // MARK: - Others -
    
    // MARK: - View Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpAppView()
    }

}


extension UIView {
    
    func setUpAppView() {
        layer.cornerRadius = 10
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 10
        layer.masksToBounds = true
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
        
        //clipsToBounds = true
        
        backgroundColor = UIColor.white
    }
}
