//
//  UIView+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/7.
//

import UIKit

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
}
