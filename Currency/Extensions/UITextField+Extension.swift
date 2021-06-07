//
//  UITextField+Extension.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import Foundation
import UIKit

extension UITextField{

   @discardableResult
   public func appLeftView(image: UIImage?, width: CGFloat = 0) -> UIButton {
       
       let widthNew = (width == 0) ? self.frame.size.height : width
       let btn = UIButton.init(type: .custom)
       btn.setImage(image, for: .normal)
       btn.isUserInteractionEnabled = false
       btn.frame = CGRect.init(x: 0, y: 0, width: widthNew, height:  self.frame.size.height)
       let view = UIView.init(frame: CGRect.init(x: (self.frame.size.width - self.frame.size.height), y: 0, width: widthNew, height:  self.frame.size.height))
       view.addSubview(btn)
       view.backgroundColor = backgroundColor
       self.leftView = view
       self.leftViewMode = .always
       return btn
   }
    
   @discardableResult
   public func rightView(image: UIImage?, width: CGFloat = 0) -> UIButton {
        
        let widthNew = (width == 0) ? self.frame.size.height : width
        let btn = UIButton.init(type: .custom)
        btn.setImage(image, for: .normal)
        btn.isUserInteractionEnabled = false
        btn.frame = CGRect.init(x:  0, y: 10, width:widthNew - 10, height:  self.frame.size.height - 20)
        let view = UIView.init(frame: CGRect.init(x: (self.frame.size.width - self.frame.size.height), y: 0, width: widthNew, height:  self.frame.size.height))
        view.addSubview(btn)
        view.backgroundColor = backgroundColor
        self.rightView = view
        self.rightViewMode = .always
        return btn
        
    }
    
    @discardableResult
    public func rightViewInfo( width: CGFloat = 0) -> UIButton {
        let widthNew = (width == 0) ? self.frame.size.height : width
        let btn = UIButton.init(type: .detailDisclosure)
        btn.frame = CGRect.init(x:0, y: 0, width:widthNew, height:  self.frame.size.height)
        self.rightView = btn
        self.rightViewMode = .always
        return btn
        
    }
    
    public func removeRightView(){
        self.rightView = nil
        self.rightViewMode = .always
        
    }
    
    func leftpedding(){
        let btn = UIButton.init(type: .custom)
        btn.setImage(nil, for: .normal)
        btn.frame = CGRect.init(x: 0, y: 0, width:10, height:  self.frame.size.height)
        self.leftView = btn
        self.leftViewMode = .always
    }
}

