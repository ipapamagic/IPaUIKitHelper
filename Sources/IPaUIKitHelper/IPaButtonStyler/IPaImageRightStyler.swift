//
//  IPaImageRightStyler.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2018/11/22.
//

import UIKit
@available(iOS, deprecated:16.0)
open class IPaImageRightStyler:IPaButtonStyler {
    @IBInspectable open var centerSpace: CGFloat = 0
    @IBInspectable open var leftSpace: CGFloat = 0
    @IBInspectable open var rightSpace: CGFloat = 0
    open override func clearStyle(_ button:UIButton) {
        button.titleEdgeInsets = UIEdgeInsets(top: button.titleEdgeInsets.top, left: 0, bottom: button.titleEdgeInsets.bottom, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: button.imageEdgeInsets.top, left: 0, bottom: button.imageEdgeInsets.bottom, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: button.contentEdgeInsets.top, left: 0, bottom: button.contentEdgeInsets.bottom, right: 0)
        
        
    }
    @objc open override func reloadStyle(_ button: UIButton) {
        
        if #available(iOS 16.0, *) {
            var configuration:UIButton.Configuration
            if let config = button.configuration {
                configuration = config
            }
            else {
                configuration = UIButton.Configuration.plain()
            }
            if let image = button.image(for: .normal) {
                configuration.imagePadding = centerSpace
                configuration.imagePlacement = .trailing
                configuration.image = image
            }
            if let text = button.title(for: .normal) {
                var title = AttributedString(text)
                title.foregroundColor = button.titleColor(for: .normal)
                title.font = button.titleLabel?.font
                configuration.attributedTitle = title
                button.setTitle(nil, for: .normal)
            }
            configuration.contentInsets = NSDirectionalEdgeInsets.zero
            button.configuration = configuration
        } else {
            
            guard let imageView = button.imageView,let titleLabel = button.titleLabel,let text = titleLabel.text,let font = button.titleLabel?.font else {
                return
            }
            let imageWidth = imageView.intrinsicContentSize.width
            let textWidth = (text as NSString).size(withAttributes: [.font:font]).width
            let space = max(0,centerSpace)
            var titleLeft = -imageWidth
            var imageLeft = textWidth
            let halfSpace = max(0,space * 0.5)
            
            let basicWidth =  imageWidth + textWidth + leftSpace + rightSpace + space
            
            let buttonSize = button.bounds.size
            if buttonSize.width > basicWidth ,leftSpace >= 0 ,rightSpace >= 0{
                //left / right space do to
                let extraSpace  = (buttonSize.width  - imageWidth - textWidth - leftSpace - rightSpace) * 0.5
                titleLeft -= extraSpace
                imageLeft += extraSpace
            }
            else {
                titleLeft -= halfSpace
                imageLeft += halfSpace
            }
            
            button.titleEdgeInsets = UIEdgeInsets(top: button.titleEdgeInsets.top, left: titleLeft, bottom: button.titleEdgeInsets.bottom, right: -titleLeft)
            button.imageEdgeInsets = UIEdgeInsets(top: button.imageEdgeInsets.top, left: imageLeft, bottom: button.imageEdgeInsets.bottom, right: -imageLeft)
            button.contentEdgeInsets = UIEdgeInsets(top: button.contentEdgeInsets.top, left: leftSpace + halfSpace, bottom: button.contentEdgeInsets.bottom, right: rightSpace + halfSpace)
        }
    }
}
