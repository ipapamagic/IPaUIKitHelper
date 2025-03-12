//
//  IPaUIUntouchableStackView.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2023/1/20.
//

import UIKit

class IPaUIUntouchableStackView: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hitView = super.hitTest(point, with: event)  {
            return hitView == self ? nil : hitView
        }
        return nil
    }
}
