//
//  IPaUIUntouchableView.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/11/27.
//

import UIKit

class IPaUIUntouchableView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return (view == self) ? nil : view
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
