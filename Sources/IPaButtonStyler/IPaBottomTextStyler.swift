//
//  IPaBottomTextStyler.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2018/11/21.
//

import UIKit
@available(iOS, deprecated:16.0)
open class IPaBottomTextStyler:IPaButtonStyler {
    @IBInspectable open var centerSpace: CGFloat = 0
    @IBInspectable open var imageOffsetX: CGFloat = 0
    //imageTopOffset greater to 0 to make image fix space from top
    @IBInspectable open var topOffset: CGFloat = -1
    open override func reloadStyle(_ button: UIButton) {
    
   
        guard let imageView = button.imageView,let titleLabel = button.titleLabel,let titleText = titleLabel.text else {
            return
        }
        var buttonSize = button.bounds.size
        
        var contentEdgeInset = UIEdgeInsets.zero
        
        let imageSize = imageView.frame.size
        let textAttributes = [NSAttributedString.Key.font: titleLabel.font as Any]
        let rect = (titleText as NSString).boundingRect(with: buttonSize,options: [.usesDeviceMetrics,.usesLineFragmentOrigin], attributes: textAttributes, context: nil)
        let titleSize = rect.size
        let originTextSize = titleText.size(withAttributes: textAttributes)
        let topOffset = max(0,self.topOffset)
        let height = imageSize.height + titleSize.height + centerSpace + topOffset
        let width = max(imageSize.width, titleSize.width)
        
        let oHeight = min(buttonSize.height,max(imageSize.height,originTextSize.height))
        
        
        let offsetW:CGFloat = abs(width - buttonSize.width) * 0.5
        contentEdgeInset.left = offsetW
        contentEdgeInset.right = offsetW
        
        let offsetH:CGFloat = abs(height - oHeight) * 0.5
        contentEdgeInset.top = offsetH
        contentEdgeInset.bottom = offsetH
        
        // topOffset < 0 then make it alignment to center
        var y = topOffset >= 0 ? (-(height - titleSize.height) * 0.5 + topOffset + imageSize.height + centerSpace) : (imageSize.height + centerSpace) * 0.5
        
        button.titleEdgeInsets = UIEdgeInsets(
            top: y, left: -imageSize.width, bottom: -y, right: 0)
        
        y = topOffset >= 0 ? -(height - imageSize.height) * 0.5 + topOffset : -(titleSize.height - centerSpace) * 0.5
        button.imageEdgeInsets = UIEdgeInsets(
            top: y, left: imageOffsetX, bottom: -y, right: -titleSize.width - imageOffsetX)

        button.contentEdgeInsets = contentEdgeInset
        
    }
}
