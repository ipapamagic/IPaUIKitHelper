//
//  UITextView+IPaUIKItHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/7.
//

import UIKit

extension UITextView {
    //@IBInspectable 
    @objc public var textPadding:CGFloat {
        get {
            return self.textContainer.lineFragmentPadding
        }
        set {
            self.textContainer.lineFragmentPadding = newValue
        }
    }
    //@IBInspectable 
    @objc public var bottomInset: CGFloat {
        get {
            return textContainerInset.bottom
        }
        set {
            textContainerInset.bottom = newValue
        }
    }
    //@IBInspectable 
    @objc public var leftInset: CGFloat {
        get {
            return textContainerInset.left
        }
        set {
            textContainerInset.left = newValue
        }
    }
    //@IBInspectable 
    @objc public var rightInset: CGFloat {
        get {
            return textContainerInset.right
        }
        set {
            textContainerInset.right = newValue
        }
    }
    //@IBInspectable 
    @objc public var topInset: CGFloat {
        get {
            return textContainerInset.top
        }
        set {
            textContainerInset.top = newValue
        }
    }

}
extension UITextView:IPaHasHTMLContent {
    public func setHtmlContent(_ content:String,encoding:String.Encoding = .utf8,replacePtToPx:Bool = true) {
        var content = replacePtToPx ? self.replaceCSSPtToPx(with: content) : content
        content += "<style>img { max-width:\(self.bounds.size.width - self.leftInset - self.rightInset)px; height: auto !important; } </style>"
        
        
        if let data = content.data(using: encoding) ,let attributedText = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil) {
            self.attributedText = attributedText
            
        }
    }
}
