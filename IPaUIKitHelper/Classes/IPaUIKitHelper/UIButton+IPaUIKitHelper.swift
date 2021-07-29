//
//  UIButton+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/27.
//

import UIKit

extension UIButton:IPaRatioFitImage {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func fitImageKeyPath() -> KeyPath<UIButton, UIImage?> {
        return \UIButton.currentBackgroundImage
    }
    @IBInspectable open var backgroundImageRatioConstraintPrority:Float {
        get {
            return ratioConstraintPrority
        }
        set {
            ratioConstraintPrority = newValue
        }
    }
}
