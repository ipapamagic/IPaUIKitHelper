//
//  UIViewController+UIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/1/18.
//

import UIKit

extension UIViewController {
    public func easyRemoveFromParent() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    public func easyAddChild(_ viewController:UIViewController,addSubView:((UIView)->())?) {
        self.addChild(viewController)
        if let addSubView = addSubView {
            addSubView(viewController.view)
        }
        else {
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubviewToFill(viewController.view)
        }
        viewController.willMove(toParent: self)
    }
}
