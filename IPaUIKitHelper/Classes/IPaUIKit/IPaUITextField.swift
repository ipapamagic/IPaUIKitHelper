//
//  IPaUITextField.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
//@IBDesignable
open class IPaUITextField: UITextField {
    
    //@IBInspectable
    @objc public var bottomInset: CGFloat {
        get {
            return textInsets.bottom
        }
        set {
            textInsets.bottom = newValue
        }
    }
    //@IBInspectable
    @objc public var leftInset: CGFloat {
        get {
            return textInsets.left
        }
        set {
            textInsets.left = newValue
        }
    }
    //@IBInspectable
    @objc public var rightInset: CGFloat {
        get {
            return textInsets.right
        }
        set {
            textInsets.right = newValue
        }
    }
    //@IBInspectable
    @objc public var topInset: CGFloat {
        get {
            return textInsets.top
        }
        set {
            textInsets.top = newValue
        }
    }
    
    //@IBInspectable
    @objc public var textInsets: UIEdgeInsets = UIEdgeInsets.zero
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    override open func placeholderRect(forBounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
