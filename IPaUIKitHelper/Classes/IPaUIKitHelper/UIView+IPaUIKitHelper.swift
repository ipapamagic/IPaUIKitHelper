//
//  UIView+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/7.
//

import UIKit
import IPaImageTool
import ObjectiveC

private var shadowSpreadHandle: UInt8 = 0
extension UIView {
    
    @IBInspectable public var maskToBounds:Bool {
        get {
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
    @IBInspectable public var cornerRadius:CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable public var borderWidth:CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable public var borderColor:UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable public var shadowBlur:CGFloat {
        get {
            return self.shadowRadius * 2
        }
        set {
            self.shadowRadius = newValue * 0.5
        }
    }
    @IBInspectable public var shadowColor:UIColor? {
        get {
            if let color = self.layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable public var shadowSpread:CGFloat {
        get {
            return objc_getAssociatedObject(self, &shadowSpreadHandle) as? CGFloat ?? 0
        }
        set {
            objc_setAssociatedObject(self, &shadowSpreadHandle, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if newValue == 0 {
                self.layer.shadowPath = nil
            }
            else {
                objc_setAssociatedObject(self, &shadowSpreadHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                        
                let dx = -newValue
                let rect = bounds.insetBy(dx: dx, dy: dx)
                
                self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
                
                self.layer.contentsScale = UIScreen.main.scale
            }
        }
    }
    @IBInspectable public var shadowRadius:CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    @IBInspectable public var shadowOffset:CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    @IBInspectable public var shadowOpacity:Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    @discardableResult
    public func applyGradient(colours: [UIColor],startPoint:CGPoint,endPoint:CGPoint,locations: [NSNumber]? = nil) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    open func setBackgroundImage(_ image:UIImage,mode:UIView.ContentMode) {
        var modifyImage:UIImage
        
        switch mode {
        case .bottom:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:(self.bounds.size.width  - image.size.width) * 0.5   , y: self.bounds.size.height - image.size.height))
                
            }) ?? image
        case.bottomLeft:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:0, y: self.bounds.size.height - image.size.height))
                
            }) ?? image
        case .bottomRight:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:self.bounds.size.width - image.size.width, y: self.bounds.size.height - image.size.height))
                
            }) ?? image
        case .center:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:(self.bounds.size.width  - image.size.width) * 0.5   , y: (self.bounds.size.height - image.size.height) * 0.5))
                
            }) ?? image
        case .left:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:self.bounds.size.width - image.size.width    , y: (self.bounds.size.height - image.size.height) * 0.5))
                
            }) ?? image
        case .right:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:0 , y: (self.bounds.size.height - image.size.height) * 0.5))
                
            }) ?? image
        case .redraw:
            modifyImage = image
        case .scaleAspectFill:
            modifyImage = image.image(aspectFillSize:self.bounds.size)
        case .scaleAspectFit:
            modifyImage = image.image(fitSize:self.bounds.size)
        case .scaleToFill:
            modifyImage = image.image(size: self.bounds.size)
        case .top:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:(self.bounds.size.width - image.size.width) * 0.5  , y: 0))
                
            }) ?? image
        case .topRight:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:self.bounds.size.width - image.size.width  , y: 0))
                
            }) ?? image
        case .topLeft:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:0  , y: 0))
                
            }) ?? image
        @unknown default:
            modifyImage = image
        }
        
        

        self.backgroundColor = UIColor(patternImage: modifyImage)
            
    }
    open func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let cornerMask = CAShapeLayer()
        cornerMask.path = path.cgPath
        layer.mask = cornerMask
    }
   
}
