//
//  IPaRatioFitImage.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/26.
//

import UIKit


protocol IPaRatioFitImage:UIView {
    associatedtype Element
    var fitImage:UIImage? {get}
    func fitImageKeyPath() -> KeyPath<Element, UIImage?>
    var ratioConstraintMultiplier:CGFloat {get set}
    
}
private var ratioConstraintProrityHandle: UInt8 = 0
private var ratioConstraintHandle: UInt8 = 0
private var fitImageObserverHandle: UInt8 = 0
extension IPaRatioFitImage where Element:UIView{
    var fitImage:UIImage? {
        return (self as! Element)[keyPath: self.fitImageKeyPath()]
    }
    var fitImageObserver:NSKeyValueObservation? {
        get {
            return objc_getAssociatedObject(self, &fitImageObserverHandle) as? NSKeyValueObservation
        }
        set {
            if newValue == nil {
                self.fitImageObserver?.invalidate()
            }
            objc_setAssociatedObject(self, &fitImageObserverHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func refreshImageRatioConstraint() {
        guard let image = fitImage else {
            self.ratioConstraintMultiplier = 0
            return
        }
        self.ratioConstraintMultiplier = image.size.width / image.size.height
        
    }
    var ratioConstraintPrority:Float {
        get {
            return objc_getAssociatedObject(self, &ratioConstraintProrityHandle) as? Float ?? 0
        }
        set {
            objc_setAssociatedObject(self, &ratioConstraintProrityHandle, (newValue == 0) ? nil : newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            
            if newValue > 0 {
                guard fitImageObserver == nil else {
                    return
                }
                
                self.fitImageObserver = (self as! Element).observe(self.fitImageKeyPath()) { object, value in
                    self.refreshImageRatioConstraint()
                }
                
            }
            else {
                self.fitImageObserver = nil
            }
        }
    }
    var ratioConstraintMultiplier:CGFloat {
        get {
            return self.ratioConstraint?.multiplier ?? 0
        }
        set {
            guard  newValue != 0 else {
                self.ratioConstraint = nil
                return
            }
            let ratioConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: newValue, constant: 0)
            ratioConstraint.priority = UILayoutPriority(rawValue: self.ratioConstraintPrority)
            self.addConstraint(ratioConstraint)
            self.ratioConstraint = ratioConstraint
        }
    }
    var ratioConstraint:NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, &ratioConstraintHandle) as? NSLayoutConstraint
        }
        set {
            if let ratioConstraint = ratioConstraint ,newValue == nil {
                self.removeConstraint(ratioConstraint)
            }
            objc_setAssociatedObject(self, &ratioConstraintHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}


