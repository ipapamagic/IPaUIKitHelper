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
            return self.contentInsets.bottom
        }
        set {
            var insets = self.contentInsets
            insets.bottom = newValue
            self.contentInsets = insets
        }
    }
    //@IBInspectable
    @objc public var leftInset: CGFloat {
        get {
            return self.contentInsets.left
        }
        set {
            var insets = self.contentInsets
            insets.left = newValue
            self.contentInsets = insets
        }
    }
    //@IBInspectable
    @objc public var rightInset: CGFloat {
        get {
            return self.contentInsets.right
        }
        set {
            var insets = self.contentInsets
            insets.right = newValue
            self.contentInsets = insets
        }
    }
    //@IBInspectable
    @objc public var topInset: CGFloat {
        get {
            return self.contentInsets.top
        }
        set {
            var insets = self.contentInsets
            insets.top = newValue
            self.contentInsets = insets
        }
    }
    @objc public var editingRightInset:CGFloat {
        get {
            return self.editingInsets.right
        }
        set {
            self.editingInsets.right = newValue
        }
    }
    @objc public var editingLeftInset:CGFloat {
        get {
            return self.editingInsets.left
        }
        set {
            self.editingInsets.left = newValue
        }
    }
    @objc public var editingTopInset:CGFloat {
        get {
            return self.editingInsets.top
        }
        set {
            self.editingInsets.top = newValue
        }
    }
    @objc public var editingBottomInset:CGFloat {
        get {
            return self.editingInsets.bottom
        }
        set {
            self.editingInsets.bottom = newValue
        }
    }
    @objc public var textRightInset:CGFloat {
        get {
            return self.textInsets.right
        }
        set {
            self.textInsets.right = newValue
        }
    }
    @objc public var textLeftInset:CGFloat {
        get {
            return self.textInsets.left
        }
        set {
            self.textInsets.left = newValue
        }
    }
    @objc public var textTopInset:CGFloat {
        get {
            return self.textInsets.top
        }
        set {
            self.textInsets.top = newValue
        }
    }
    @objc public var textBottomInset:CGFloat {
        get {
            return self.textInsets.bottom
        }
        set {
            self.textInsets.bottom = newValue
        }
    }
    //@IBInspectable
    @objc public var contentInsets:UIEdgeInsets {
        get {
            return self.textInsets
        }
        set {
            textInsets = newValue
            editingInsets = newValue
        }
    }
    @objc public var editingInsets: UIEdgeInsets = UIEdgeInsets.zero
    @objc public var textInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.textRect(forBounds: bounds)
        return originalRect.inset(by: textInsets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.editingRect(forBounds: bounds)
        return originalRect.inset(by: editingInsets)
    }
    override open func placeholderRect(forBounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
