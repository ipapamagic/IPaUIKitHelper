//
//  IPaNestedInnerScrollView+IPaFitContentWebViewContainer.swift
//  
//
//  Created by IPa Chen on 2022/10/17.
//

import UIKit
import IPaFitContent
extension IPaNestedInnerScrollView:IPaFitContentWebViewContainer {
    public func onWebViewContentSizeUpdate(_ webView: IPaFitContentWebView) {
        self.layoutIfNeeded()
    }
}
