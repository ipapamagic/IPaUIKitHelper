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
        let imageSize = imageView.frame.size
        let textAttributes = [NSAttributedString.Key.font: titleLabel.font as Any]
        let rect = (titleText as NSString).boundingRect(with: button.bounds.size,options: [.usesDeviceMetrics,.usesLineFragmentOrigin], attributes: textAttributes, context: nil)
        let titleSize = rect.size
        
        let height = imageSize.height + titleSize.height + centerSpace
        
        var topOffset:CGFloat = 0
        if  self.topOffset >= 0 {
            topOffset = self.topOffset - ((button.bounds.height - height) * 0.5)
        }
        
        
        var y = (imageSize.height + centerSpace) * 0.5 + topOffset
        
        button.titleEdgeInsets = UIEdgeInsets(
            top: y, left: -imageSize.width, bottom: -y, right: 0)
        
        // raise the image and push it right so it appears centered
        //  above the text
        
        y = -(titleSize.height + centerSpace) * 0.5 + topOffset
        button.imageEdgeInsets = UIEdgeInsets(
            top: y, left: imageOffsetX, bottom: -y, right: -titleSize.width - imageOffsetX)
//        let width = max(imageSize.width,titleSize.width)
        
//        let x = (width - button.bounds.width) * 0.5
        
        let originTextSize = titleText.size(withAttributes: textAttributes)
        
        y = (height - max(imageSize.height,originTextSize.height)) * 0.5
        
        button.contentEdgeInsets = UIEdgeInsets(top: y + topOffset, left: 0, bottom: y, right: 0)
        
    }
}
