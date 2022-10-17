//
//  UILabel+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/26.
//

import UIKit

extension UILabel:IPaHasHTMLContent {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    public func setHtmlContent(_ content:String,encoding:String.Encoding = .utf8,replacePtToPx:Bool = true) {
        var content = replacePtToPx ? self.replaceCSSPtToPx(with: content) : content
        let rect = self.textRect(forBounds: self.bounds, limitedToNumberOfLines: self.numberOfLines)
        content += "<style>img { max-width:\(self.bounds.size.width - rect.width)px; height: auto !important; } </style>"
        
        
        if let data = content.data(using: encoding) ,let attributedText = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil) {
            //fit image to content .... css not work ,need to do it yourself
//            let maxWidth = self.bounds.width
//            let text = NSMutableAttributedString(attributedString: attributedText)
//            text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSMakeRange(0, text.length), options: .init(rawValue: 0), using: { (value, range, stop) in
//                if let attachement = value as? NSTextAttachment {
//                    let image = attachement.image(forBounds: attachement.bounds, textContainer: NSTextContainer(), characterIndex: range.location)!
//                    if image.size.width > maxWidth {
//                        let newImage = image.image(fitWidth: maxWidth)
//                        let newAttribut = NSTextAttachment()
//                        newAttribut.image = newImage
//                        text.addAttribute(NSAttributedString.Key.attachment, value: newAttribut, range: range)
//                    }
//                }
//            })

            self.attributedText = attributedText
            
        }
    }
}
