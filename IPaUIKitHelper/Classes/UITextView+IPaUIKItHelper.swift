//
//  UITextView+IPaUIKItHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/7.
//

import UIKit

extension UITextView {
    @IBInspectable public var bottomInset: CGFloat {
        get {
            return textContainerInset.bottom
        }
        set {
            textContainerInset.bottom = newValue
        }
    }
    @IBInspectable public var leftInset: CGFloat {
        get {
            return textContainerInset.left
        }
        set {
            textContainerInset.left = newValue
        }
    }
    @IBInspectable public var rightInset: CGFloat {
        get {
            return textContainerInset.right
        }
        set {
            textContainerInset.right = newValue
        }
    }
    @IBInspectable public var topInset: CGFloat {
        get {
            return textContainerInset.top
        }
        set {
            textContainerInset.top = newValue
        }
    }

}
