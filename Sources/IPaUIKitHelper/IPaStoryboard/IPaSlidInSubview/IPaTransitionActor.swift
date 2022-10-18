//
//  IPaTransitionActor.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/2/20.
//

import UIKit

public protocol IPaTransitionActor:UIViewController {

    var slideInController:IPaSlideInSubviewController? {get set}

}

private var associatedObjectHandle: UInt8 = 0
extension IPaTransitionActor {
    public var slideInController:IPaSlideInSubviewController? {
        get {
            guard let controller =  objc_getAssociatedObject(self, &associatedObjectHandle) as? IPaSlideInSubviewController else {
                return nil
            }
            return controller
        }
        set {
            objc_setAssociatedObject(self, &associatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public func dismissTransition() {
        self.slideInController?.dismissTransition()
    }
}
