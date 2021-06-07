//
//  UIView+Extension.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import UIKit

extension UIView {
    
    // MARK: Set & Get Frame
    
    /**
     Get Set x Position
     
     - parameter x: CGFloat
     by DaRk-_-D0G
     */
    var x:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    /**
     Get Set y Position
     
     - parameter y: CGFloat
     by DaRk-_-D0G
     */
    var y:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    /**
     Get Set Height
     
     - parameter height: CGFloat
     by DaRk-_-D0G
     */
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    /**
     Get Set Width
     
     - parameter width: CGFloat
     by DaRk-_-D0G
     */
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    
    // MARK: top, right, bottom, left, center x&y and size|origin
    
    public var top: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    public var right: CGFloat {
        get { return self.frame.origin.x + self.width }
        set { self.frame.origin.x = newValue - self.width }
    }
    public var bottom: CGFloat {
        get { return self.frame.origin.y + self.height }
        set { self.frame.origin.y = newValue - self.height }
    }
    public var left: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    
    public var centerX: CGFloat{
        get { return self.center.x }
        set { self.center = CGPoint(x: newValue,y: self.centerY) }
    }
    public var centerY: CGFloat {
        get { return self.center.y }
        set { self.center = CGPoint(x: self.centerX,y: newValue) }
    }
    
    public var origin: CGPoint {
        set { self.frame.origin = newValue }
        get { return self.frame.origin }
    }
    public var size: CGSize {
        set { self.frame.size = newValue }
        get { return self.frame.size }
    }
    
    // MARK: - Others -
    
    public class func fromNib(_ nibNameOrNil:String) ->  UIView {
        return  Bundle.main.loadNibNamed(nibNameOrNil, owner: self, options: nil)!.first as! UIView
    }
    public func makeRound(borderWidth: CGFloat = 1, borderColor: UIColor){
        self.layer.cornerRadius  = self.layer.frame.height / 2
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func bottomLine(color: UIColor = .white) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(0, height - 1, width, 1)
        bottomLine.backgroundColor = color.cgColor
        self.layer.addSublayer(bottomLine)
    }
    
    // MARK: - IBInspectable -
    @IBInspectable public var viewCornerRadius: CGFloat {
        get { return self.viewCornerRadius }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var viewBorderColor: UIColor? {
        get { return layer.borderColor.flatMap { UIColor(cgColor: $0) } }
        set { layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var dropShadow: Bool {
        set{
            if newValue {
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.22
                layer.shadowRadius = 2.7
                layer.shadowOffset = CGSize.zero
            } else {
                layer.shadowColor = UIColor.clear.cgColor
                layer.shadowOpacity = 0
                layer.shadowRadius = 0
                layer.shadowOffset = CGSize.zero
            }
        }
        get {
            return layer.shadowOpacity > 0
        }
    }
    
    @IBInspectable
    var shadow: Bool {
         get {
              return layer.shadowOpacity > 0.0
         }
         set {
            if newValue == true {
                let layer = self.layer
                layer.masksToBounds = false
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 0)
                layer.shadowRadius = 5
                layer.shadowOpacity = 0.2
            }
        }
    }
    
    @IBInspectable
    var bottomCorner: Bool {
         get {
              return true
         }
         set {
            if newValue == true {
                self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 20)
            }
        }
    }
    
    @IBInspectable
    var topCorner: Bool {
         get {
              return true
         }
         set {
            if newValue == true {
                self.roundCorners(corners: [.topLeft, .topRight], radius: 20)
            }
        }
    }
}
