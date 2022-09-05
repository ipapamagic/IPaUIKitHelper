//
//  IPaUILabel.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/28.
//
//

import UIKit
//@IBDesignable
open class IPaUILabel: UILabel{
//    @IBInspectable

    @objc public var bottomInset: CGFloat {
        get {
            return textInsets.bottom
        }
        set {
            textInsets.bottom = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
//    @IBInspectable
    @objc public var leftInset: CGFloat {
        get {
            return textInsets.left
        }
        set {
            textInsets.left = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
//    @IBInspectable
    @objc public var rightInset: CGFloat {
        get {
            return textInsets.right
        }
        set {
            textInsets.right = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
//    @IBInspectable
    @objc public var topInset: CGFloat {
        get {
            return textInsets.top
        }
        set {
            textInsets.top = newValue
            self.invalidateIntrinsicContentSize()
        }
    }
    
//    @IBInspectable
    @objc public var textInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override var intrinsicContentSize: CGSize
    {
        get {
            var size = super.intrinsicContentSize
            size.width += self.textInsets.left + self.textInsets.right
            size.height += self.textInsets.top + self.textInsets.bottom
            return size
        }
    }
    open override func drawText(in rect: CGRect) {
        super.drawText(in:rect.inset(by: self.textInsets))
    }
    
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        let textRect = bounds.inset(by: self.textInsets)
        return super.textRect(forBounds: textRect, limitedToNumberOfLines: numberOfLines)
    }
    
}
