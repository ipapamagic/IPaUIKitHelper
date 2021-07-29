//
//  IPaButtonStyler.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2018/11/22.
//

import UIKit
import ObjectiveC
open class IPaButtonStyler:NSObject {
    var textObserver:NSKeyValueObservation? {
        willSet {
            if newValue == nil {
                textObserver?.invalidate()
            }
        }
    }
    var frameObserver:NSKeyValueObservation? {
        willSet {
            if newValue == nil {
                frameObserver?.invalidate()
            }
        }
    }
    var imageObserver:NSKeyValueObservation? {
        willSet {
            if newValue == nil {
                imageObserver?.invalidate()
            }
        }
    }
    open weak var button:UIButton? {
        didSet {
            if let button = button {
                self.frameObserver = button.observe(\.frame, changeHandler: { button, value in
                    self.clearStyle()
                    self.reloadStyle()
                })
                self.textObserver = button.observe(\.titleLabel?.text, changeHandler: { button, value in
                    self.clearStyle()
                    self.reloadStyle()
                })
                self.imageObserver = button.observe(\.currentImage, changeHandler: { button, value in
                    self.clearStyle()
                    self.reloadStyle()
                })
                self.clearStyle()
                self.reloadStyle()
            }
            else {
                
                self.frameObserver = nil
                self.imageObserver = nil
                self.textObserver = nil
            }
        }
    }
    open func clearStyle() {
        button?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button?.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    open func reloadStyle() {
        
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        //can not get correct frame size , so make a timer to update style
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.reloadStyle()
        }
        
        
    }
}
private var stylerHandle: UInt8 = 0
extension UIButton {
    @IBOutlet open var styler:IPaButtonStyler? {
        get {
            return objc_getAssociatedObject(self, &stylerHandle) as? IPaButtonStyler
        }
        set {
            newValue?.button = self
            objc_setAssociatedObject(self, &stylerHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
    }
 
 
}
