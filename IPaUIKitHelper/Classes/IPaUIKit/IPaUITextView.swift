//
//  IPaUITextView.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
//@IBDesignable
open class IPaUITextView: UITextView {
    
    @IBInspectable open var caretHeight:CGFloat = 0
    @IBInspectable open var placeholder:String?
        {
        get {
            return placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
            self.setNeedsDisplay()
        }
        
    }
    @IBInspectable open var placeholderColor:UIColor
        {
        get {
            return placeholderLabel.textColor
        }
        set {
            placeholderLabel.textColor = newValue
        }
    }
    var placeholderLeadingConstraint:NSLayoutConstraint?
    var placeholderTopConstraint:NSLayoutConstraint?
    var placeholderTrailingConstraint:NSLayoutConstraint?
    var placeholderBottomConstraint:NSLayoutConstraint?
    lazy var placeholderLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        placeholderLeadingConstraint = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: textContainerInset.left + textContainer.lineFragmentPadding)
        self.addConstraint(placeholderLeadingConstraint!)
        placeholderTopConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: textContainerInset.top)
        self.addConstraint(placeholderTopConstraint!)
        placeholderBottomConstraint = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .bottom, multiplier: 1, constant: textContainerInset.bottom)
        self.addConstraint(placeholderBottomConstraint!)
        setNeedsDisplay()
        return label
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var textChangedObserver:NSObjectProtocol?
    override open func awakeFromNib() {
        super.awakeFromNib()
        addTextChangeObserver()
        
    }
    func addTextChangeObserver() {
        
        textChangedObserver = NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification, object: self, queue: nil, using: {
            noti in
            self.setNeedsDisplay()
        })
        
    }
    deinit {
        if let textChangedObserver = textChangedObserver {
            NotificationCenter.default.removeObserver(textChangedObserver)
        }
        //        removeObserver(self, forKeyPath: "font")
        //        removeObserver(self, forKeyPath: "text")
        //        removeObserver(self, forKeyPath: "placeholder")
        //        removeObserver(self, forKeyPath: "placeholderColor")
        //        removeObserver(self, forKeyPath: "textContainerInset")
    }
    override open func draw(_ rect: CGRect) {
        //return if hasText
        if self.hasText {
            placeholderLabel.isHidden = true
            return
        }
        placeholderLabel.isHidden = false
        
        placeholderLeadingConstraint?.constant = textContainerInset.left + textContainer.lineFragmentPadding
        placeholderTopConstraint?.constant = textContainerInset.top
        placeholderBottomConstraint?.constant = textContainerInset.bottom
        placeholderTrailingConstraint?.constant = textContainerInset.right
        
//        // attr
//        var attrs:[NSAttributedString.Key:Any] = [NSAttributedString.Key.foregroundColor:self.placeholderColor]
//        if let font = self.font {
//            attrs[NSAttributedString.Key.font] = font
//        }
//
//        var placeHolderRect = rect
//        //draw text
//        placeHolderRect.origin.x = textContainerInset.left + textContainer.lineFragmentPadding
//        placeHolderRect.origin.y = textContainerInset.top
//        placeHolderRect.size.width = self.bounds.width  - textContainerInset.left - textContainerInset.right - textContainer.lineFragmentPadding - textContainer.lineFragmentPadding
//        placeHolderRect.size.height = self.bounds.height - textContainerInset.top - textContainerInset.bottom
//        (self.placeholder as NSString).draw(at: placeHolderRect.origin, withAttributes: attrs)
//
    }
//    override open func layoutSubviews() {
//        super.layoutSubviews()
//        self.setNeedsDisplay()
//    }
    override open func caretRect(for position: UITextPosition) -> CGRect {
        var superRect = super.caretRect(for:position)
        if caretHeight <= 0 {
            return superRect
        }
        superRect.size.height = caretHeight
        // "descender" is expressed as a negative value,
        // so to add its height you must subtract its value
        
        return superRect
//        if caretHeight == 0 {
//            return superRect
//        }
//        superRect.size.height = caretHeight
//        return superRect
    }
    
    
}
