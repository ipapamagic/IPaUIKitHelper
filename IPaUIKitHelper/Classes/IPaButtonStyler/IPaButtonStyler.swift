//
//  IPaButtonStyler.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2018/11/22.
//

import UIKit
import ObjectiveC

@available(iOS, deprecated:15.0)
private var textObserverHandle: UInt8 = 0
@available(iOS, deprecated:15.0)
private var boundsObserverHandle: UInt8 = 0
@available(iOS, deprecated:15.0)
private var imageObserverHandle: UInt8 = 0
@available(iOS, deprecated:15.0)
open class IPaButtonStyler:NSObject {
    
    open func clearStyle(_ button:UIButton) {
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    open func reloadStyle(_ button:UIButton) {
        
    }
    
}
@available(iOS, deprecated:15.0)
private var stylerHandle: UInt8 = 0
extension UIButton {
    @available(iOS, deprecated:15.0)
    fileprivate func reloadStyler() {
        guard let styler = self.styler else {
            return
        }
        styler.clearStyle(self)
        styler.reloadStyle(self)
    }
    @available(iOS, deprecated:15.0)
    fileprivate func addStylerObserver() {
        var observer = objc_getAssociatedObject(self, &textObserverHandle) as? NSKeyValueObservation
        if observer == nil {
            observer = self.observe(\.titleLabel?.text, changeHandler: { button, value in
                self.reloadStyler()
            })
                
            objc_setAssociatedObject(self, &textObserverHandle, observer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        observer = objc_getAssociatedObject(self, &boundsObserverHandle) as? NSKeyValueObservation
        if observer == nil {
            observer = self.observe(\.bounds, changeHandler: { button, value in
                self.reloadStyler()
            })
            objc_setAssociatedObject(self, &boundsObserverHandle, observer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        observer = objc_getAssociatedObject(self, &imageObserverHandle) as? NSKeyValueObservation
        if observer == nil {
            observer = self.observe(\.currentImage, changeHandler: { button, value in
                self.reloadStyler()
            })
            objc_setAssociatedObject(self, &imageObserverHandle, observer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            
        }
    }
    @available(iOS, deprecated:15.0)
    @IBOutlet open var styler:IPaButtonStyler? {
        get {
            return objc_getAssociatedObject(self, &stylerHandle) as? IPaButtonStyler
        }
        set {
            objc_setAssociatedObject(self, &stylerHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let styler = newValue {
                styler.clearStyle(self)
                styler.reloadStyle(self)
                self.addStylerObserver()
            }
        }
    }
 
 
}
