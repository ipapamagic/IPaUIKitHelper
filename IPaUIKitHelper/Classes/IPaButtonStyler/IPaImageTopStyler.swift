//
//  IPaImageTopStyler.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/1/5.
//

import UIKit

class IPaImageTopStyler: IPaButtonStyler {
    @IBInspectable open var centerSpace: CGFloat = 0
    @IBInspectable open var topSpace: CGFloat = 0
    open override func reloadStyle() {
        guard let button = button,let imageView = button.imageView,let titleLabel = button.titleLabel,let titleText = titleLabel.text else {
            return
        }
        let imageSize = imageView.frame.size
        let titleSize = titleText.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font as Any])
        var y = (-button.bounds.height + titleSize.height) * 0.5 +  centerSpace + imageSize.height + topSpace
        button.titleEdgeInsets = UIEdgeInsets(
            top: y, left: -imageSize.width, bottom: -y, right: 0)
        
        // raise the image and push it right so it appears centered
        //  above the text
        
        y = (-button.bounds.height + imageSize.height) * 0.5 + topSpace
        button.imageEdgeInsets = UIEdgeInsets(
            top: y, left: 0, bottom: -y, right: -titleSize.width)
        let width = max(imageSize.width,titleSize.width)
        let height = imageSize.height + titleSize.height + centerSpace
        let x = (width - button.bounds.width) * 0.5
        y = (height - button.bounds.height) * 0.5
        button.contentEdgeInsets = UIEdgeInsets(top: y, left: x, bottom: y, right: x)
    }
}
