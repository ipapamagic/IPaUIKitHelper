//
//  UIPageViewController+UIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/9/11.
//

import UIKit

extension UIPageViewController {
    public var pageScrollView:UIScrollView? {
        for view in view.subviews {
            if let subView = view as? UIScrollView {
                return subView
            }
        }
        return nil
    }
    public var isPagingEnabled: Bool {
           get {
               return self.pageScrollView?.isScrollEnabled ?? false
               
           }
           set {
               self.pageScrollView?.isScrollEnabled = newValue
               
           }
       }
}
