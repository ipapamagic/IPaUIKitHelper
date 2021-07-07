//
//  WKWebView+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/7.
//

import UIKit
import WebKit
import IPaLog
extension WKWebView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable open var isScrollEnabled: Bool {
        get {
            return self.scrollView.isScrollEnabled
        }
        set  {
            self.scrollView.isScrollEnabled = newValue
        }
    }
    @IBInspectable open var bounces: Bool {
        get {
            return self.scrollView.bounces
        }
        set  {
            self.scrollView.bounces = newValue
        }
    }
}
