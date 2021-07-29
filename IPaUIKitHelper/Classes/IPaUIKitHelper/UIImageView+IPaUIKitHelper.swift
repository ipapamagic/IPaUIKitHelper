//
//  UIImageView+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/27.
//

import UIKit

extension UIImageView :IPaRatioFitImage {
    func fitImageKeyPath() -> KeyPath<UIImageView, UIImage?> {
        return \UIImageView.image
    }
    
    @IBInspectable open var imageRatioConstraintPrority:Float {
        get {
            return ratioConstraintPrority
        }
        set {
            ratioConstraintPrority = newValue
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var fitImage: UIImage? {
        return self.image
    }
}
