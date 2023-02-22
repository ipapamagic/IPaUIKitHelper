//
//  IPaUIUntouchableView.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/11/27.
//

import UIKit

open class IPaUIUntouchableView: UIView {
    public enum TouchMode:Int {
        case untouchable = 0 //disable touch
        case touchable = 1    //enable touch
        case catchAllHit = 2 //catch all hitTest except view in touchableView array
    }
    
    //add relative view in to touchableView , hitTest whill check these view first wheather or not these views is UserInteractive or not
    lazy var touchableViews = [UIView]()
    public var touchMode = TouchMode.untouchable
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        for index in 0 ..< touchableViews.count {
            let viewIdx = touchableViews.count - index - 1
            let tView = touchableViews[viewIdx]
            let point = self.convert(point, to: tView)
            if let hitView = tView.hitTest(point, with: event) {
                touchableViews.remove(at: viewIdx)
                touchableViews.append(tView)
                return hitView
            }
        }
        if touchMode == .catchAllHit {
            return self
        }
        let view = super.hitTest(point, with: event)
        return (touchMode == .untouchable && view == self) ? nil : view
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   
    public func addTouchableView(_ view:UIView) {
        guard view != self ,!self.touchableViews.contains(view) else {
            return
        }
        self.touchableViews.append(view)
    }
    public func removeTouchableView(_ view:UIView) {
        guard let index = self.touchableViews.firstIndex(of: view) else {
            return
        }
        self.touchableViews.remove(at: index)
    }
}
