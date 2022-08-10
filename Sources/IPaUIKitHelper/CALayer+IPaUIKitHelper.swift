//
//  CALayer+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/1/21.
//

import UIKit

extension CALayer {
    public var borderUIColor: UIColor? {
        set {
            self.borderColor = newValue?.cgColor
        }

        get {
            if let color = self.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
    }
}
