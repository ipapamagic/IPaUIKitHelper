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
    
    //@IBInspectable
    @objc open var caretHeight:CGFloat = 0
    //@IBInspectable
    @objc open var placeholder:String?
        {
        get {
            return placeholderLabel.text
        }
        set {
            placeholderLabel.text = newValue
            self.setNeedsDisplay()
        }
        
    }
    //@IBInspectable
    @objc open var placeholderColor:UIColor
        {
        get {
            return placeholderLabel.textColor
        }
        set {
            placeholderLabel.textColor = newValue
        }
    }
    @objc open var placeholderFont:UIFont
        {
        get {
            return placeholderLabel.font
        }
        set {
            placeholderLabel.font = newValue
        }
    }
    @objc open var placeholderAttributedText:NSAttributedString?
        {
        get {
            return placeholderLabel.attributedText
        }
        set {
            placeholderLabel.attributedText = newValue
        }
    }
    var placeholderLeadingConstraint:NSLayoutConstraint?
    var placeholderTopConstraint:NSLayoutConstraint?
    var placeholderTrailingConstraint:NSLayoutConstraint?
    var placeholderBottomConstraint:NSLayoutConstraint?
    var placeholderWidthConstraint:NSLayoutConstraint?
    lazy var placeholderLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        self.addSubview(label)
        placeholderWidthConstraint = label.widthAnchor.constraint(equalTo: self.widthAnchor,constant: -(textContainerInset.left + textContainer.lineFragmentPadding + textContainerInset.right + textContainer.lineFragmentPadding))
        placeholderLeadingConstraint = label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textContainerInset.left + textContainer.lineFragmentPadding)
        placeholderTrailingConstraint = self.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: textContainerInset.right + textContainer.lineFragmentPadding)
        placeholderTopConstraint = label.topAnchor.constraint(equalTo: self.topAnchor,constant: textContainerInset.top)
        placeholderBottomConstraint = self.bottomAnchor.constraint(equalTo: label.bottomAnchor,constant: textContainerInset.bottom)
        placeholderLeadingConstraint?.isActive = true
        placeholderTrailingConstraint?.isActive = true
        placeholderTopConstraint?.isActive = true
        placeholderBottomConstraint?.isActive = true
        placeholderWidthConstraint?.isActive = true
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
        placeholderTrailingConstraint?.constant = -textContainerInset.right - textContainer.lineFragmentPadding
        
        placeholderWidthConstraint?.constant = -textContainerInset.right - textContainer.lineFragmentPadding - textContainerInset.left - textContainer.lineFragmentPadding

    }

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
