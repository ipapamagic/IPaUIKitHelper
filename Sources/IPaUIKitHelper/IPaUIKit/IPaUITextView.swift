//
//  IPaUITextView.swift
//  Pods
//
//  Created by IPa Chen on 2017/4/23.
//
//

import UIKit
import Combine
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
            placeholderLabel.layoutIfNeeded()
        }
    }
    @objc override open var text: String! {
        didSet {
            placeholderLabel.isHidden = self.hasText
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
//    var placeholderWidthConstraint:NSLayoutConstraint?
    var placeholderHeightConstraint:NSLayoutConstraint?
    var hasTextAnyCancellable:AnyCancellable?
    lazy var placeholderLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        self.addSubview(label)
//        self.placeholderWidthConstraint = label.widthAnchor.constraint(equalTo: self.widthAnchor,constant: -self.textContainerInset.right - self.textContainer.lineFragmentPadding - self.textContainerInset.left - self.textContainer.lineFragmentPadding)
        self.placeholderHeightConstraint = self.heightAnchor.constraint(greaterThanOrEqualTo: label.heightAnchor, constant: (textContainerInset.top + textContainerInset.bottom + textContainer.lineFragmentPadding + textContainer.lineFragmentPadding))
        placeholderLeadingConstraint = label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textContainerInset.left + textContainer.lineFragmentPadding)
        placeholderTrailingConstraint = self.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: -self.textContainerInset.right - self.textContainer.lineFragmentPadding)
        placeholderTopConstraint = label.topAnchor.constraint(equalTo: self.topAnchor,constant: self.textContainerInset.top)
        placeholderBottomConstraint = self.bottomAnchor.constraint(greaterThanOrEqualTo: label.bottomAnchor, constant: self.textContainerInset.bottom)
        
        placeholderLeadingConstraint?.isActive = true
        placeholderTrailingConstraint?.isActive = true
        placeholderTopConstraint?.isActive = true
        placeholderBottomConstraint?.isActive = true
//        placeholderWidthConstraint?.isActive = true
        placeholderHeightConstraint?.isActive = true
        setNeedsDisplay()
        return label
    }()
//    var textChangedAnyCancellable:AnyCancellable?
//    var placeholderAnyCancellable:AnyCancellable?
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
    override open func awakeFromNib() {
        super.awakeFromNib()
        addTextChangeObserver()
        
    }
    func addTextChangeObserver() {
        self.hasTextAnyCancellable = self.publisher(for: \.hasText).sink(receiveValue: {
            [weak self]  hasText in
            self?.placeholderLabel.isHidden = hasText
        })
//        textChangedAnyCancellable = NotificationCenter.default.publisher(for: UITextView.textDidChangeNotification,object: self).sink(receiveValue: { notification in
//            self.placeholderLabel.isHidden = self.hasText
//            
//            self.placeholderLeadingConstraint?.constant = self.textContainerInset.left + self.textContainer.lineFragmentPadding
//            self.placeholderTopConstraint?.constant = self.textContainerInset.top
//            self.placeholderBottomConstraint?.constant = self.textContainerInset.bottom
//            self.placeholderTrailingConstraint?.constant = -self.textContainerInset.right - self.textContainer.lineFragmentPadding
//            
//            self.placeholderWidthConstraint?.constant = -self.textContainerInset.right - self.textContainer.lineFragmentPadding - self.textContainerInset.left - self.textContainer.lineFragmentPadding
            
//        })
        
    }
    deinit {
        
        //        removeObserver(self, forKeyPath: "font")
        //        removeObserver(self, forKeyPath: "text")
        //        removeObserver(self, forKeyPath: "placeholder")
        //        removeObserver(self, forKeyPath: "placeholderColor")
        //        removeObserver(self, forKeyPath: "textContainerInset")
    }
   
//    override open func draw(_ rect: CGRect) {
//        //return if hasText
//        placeholderLabel.isHidden = self.hasText
//        
//        placeholderLeadingConstraint?.constant = textContainerInset.left + textContainer.lineFragmentPadding
//        placeholderTopConstraint?.constant = textContainerInset.top
//        placeholderBottomConstraint?.constant = textContainerInset.bottom
//        placeholderTrailingConstraint?.constant = -textContainerInset.right - textContainer.lineFragmentPadding
//        
//        placeholderWidthConstraint?.constant = -textContainerInset.right - textContainer.lineFragmentPadding - textContainerInset.left - textContainer.lineFragmentPadding
//
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
    }
    
    
}
