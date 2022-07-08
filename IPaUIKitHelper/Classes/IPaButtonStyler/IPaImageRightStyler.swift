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
    open override func reloadStyle(_ button: UIButton) {
        guard let imageView = button.imageView,let titleLabel = button.titleLabel,let text = titleLabel.text,let font = button.titleLabel?.font else {
            return
        }
        let imageWidth = imageView.intrinsicContentSize.width
        let textWidth = (text as NSString).size(withAttributes: [.font:font]).width
        var space = centerSpace
        var titleLeft = -imageWidth
        var imageLeft = textWidth
        var contentEdgeInsets = UIEdgeInsets.zero
        var halfSpace = space
        if centerSpace > 0 {
            halfSpace = max(0,space * 0.5)
            contentEdgeInsets = UIEdgeInsets(top: button.contentEdgeInsets.top, left: leftSpace + halfSpace, bottom: button.contentEdgeInsets.bottom, right: rightSpace + halfSpace)
        }
        else {
            //dynamic center space
            let buttonSize = button.bounds.size
            space = (buttonSize.width  - imageWidth - textWidth - leftSpace - rightSpace)
            titleLeft += leftSpace
            imageLeft -= rightSpace
            
            if space > 0 {
                let extraSpace = space * 0.5
                contentEdgeInsets = UIEdgeInsets(top: button.contentEdgeInsets.top, left: extraSpace, bottom: button.contentEdgeInsets.bottom, right: extraSpace)
            }
            halfSpace = max(0,space * 0.5)
        }
        
        titleLeft -= halfSpace
        imageLeft += halfSpace
        button.titleEdgeInsets = UIEdgeInsets(top: button.titleEdgeInsets.top, left: titleLeft, bottom: button.titleEdgeInsets.bottom, right: -titleLeft)
        button.imageEdgeInsets = UIEdgeInsets(top: button.imageEdgeInsets.top, left: imageLeft, bottom: button.imageEdgeInsets.bottom, right: -imageLeft)
        button.contentEdgeInsets = contentEdgeInsets
    }
}
