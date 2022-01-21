//
//  IPaImageRightStyler.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2018/11/22.
//

import UIKit
@available(iOS, deprecated:15.0)
open class IPaImageRightStyler:IPaButtonStyler {
    @IBInspectable open var centerSpace: CGFloat = 0
    @IBInspectable open var leftSpace: CGFloat = 0
    @IBInspectable open var rightSpace: CGFloat = 0
    open override func reloadStyle(_ button: UIButton) {
        guard let imageView = button.imageView,let image = imageView.image,let titleLabel = button.titleLabel,let text = titleLabel.text,let font = button.titleLabel?.font else {
            return
        }
        let textLabelWidth = button.bounds.width - image.size.width - leftSpace - rightSpace
        let textWidth = min(textLabelWidth,(text as NSString).size(withAttributes: [.font:font]).width)
        let imageWidth = image.size.width
        
        let space = (centerSpace <= 0) ? (button.bounds.width - leftSpace - rightSpace - imageWidth - textWidth) : centerSpace
        
        let halfSpace = max(0,space * 0.5)
        let titleLeft = -imageWidth - halfSpace
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: titleLeft, bottom: 0, right: (space >= 0) ? -titleLeft : -titleLeft - space)
        let imageLeft = textWidth + halfSpace + ((space >= 0) ? 0 : space)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: imageLeft, bottom: 0, right: -imageLeft)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: halfSpace + leftSpace, bottom: 0, right: halfSpace + rightSpace)
        
    }
}
