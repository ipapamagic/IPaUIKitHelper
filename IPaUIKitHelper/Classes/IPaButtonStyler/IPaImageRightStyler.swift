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
    @IBInspectable open var textWidthOffset: CGFloat = 0
    open override func clearStyle(_ button:UIButton) {
        button.titleEdgeInsets = UIEdgeInsets(top: button.titleEdgeInsets.top, left: 0, bottom: button.titleEdgeInsets.bottom, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: button.imageEdgeInsets.top, left: 0, bottom: button.imageEdgeInsets.bottom, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: button.contentEdgeInsets.top, left: 0, bottom: button.contentEdgeInsets.bottom, right: 0)
    }
    open override func reloadStyle(_ button: UIButton) {
        guard let imageView = button.imageView,let titleLabel = button.titleLabel,let text = titleLabel.text,let font = button.titleLabel?.font else {
            return
        }
        let imageWidth = imageView.bounds.width
        let textLabelWidth = button.bounds.width - imageWidth - leftSpace - rightSpace
        let textWidth = min(textLabelWidth,(text as NSString).size(withAttributes: [.font:font]).width) + textWidthOffset
        
        
        let space = ((centerSpace <= 0) ? (button.bounds.width - leftSpace - rightSpace - imageWidth - textWidth) : centerSpace) + textWidthOffset
        
        let halfSpace = max(0,space * 0.5)
        let titleLeft = -imageWidth - halfSpace
        button.titleEdgeInsets = UIEdgeInsets(top: button.titleEdgeInsets.top, left: titleLeft, bottom: button.titleEdgeInsets.bottom, right: -titleLeft)
        let imageLeft = textWidth + halfSpace
        button.imageEdgeInsets = UIEdgeInsets(top: button.imageEdgeInsets.top, left: imageLeft, bottom: button.imageEdgeInsets.bottom, right: -imageLeft)
        button.contentEdgeInsets = UIEdgeInsets(top: button.contentEdgeInsets.top, left: halfSpace + leftSpace, bottom: button.contentEdgeInsets.bottom, right: halfSpace + rightSpace)
        
    }
}
