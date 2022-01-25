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
    open override func reloadStyle(_ button: UIButton) {
    
   
        guard let imageView = button.imageView,let titleLabel = button.titleLabel,let titleText = titleLabel.text else {
            return
        }
        let imageSize = imageView.frame.size
        var y = (imageSize.height + centerSpace) * 0.5
        button.titleEdgeInsets = UIEdgeInsets(
            top: y, left: -imageSize.width, bottom: -y, right: 0)
        
        // raise the image and push it right so it appears centered
        //  above the text
        let titleSize = titleText.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font as Any])
        y = -(titleSize.height + centerSpace) * 0.5
        button.imageEdgeInsets = UIEdgeInsets(
            top: y, left: 0, bottom: -y, right: -titleSize.width)
        let width = max(imageSize.width,titleSize.width)
        let height = imageSize.height + titleSize.height + centerSpace
        let x = (width - button.bounds.width) * 0.5
        y = (height - button.bounds.height) * 0.5
        button.contentEdgeInsets = UIEdgeInsets(top: y, left: x, bottom: y, right: x)
    
    
        
        
        
        
    }
}
