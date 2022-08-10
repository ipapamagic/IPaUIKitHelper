//
//  UIButton+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/27.
//

import UIKit

extension UIButton:IPaRatioFitImage {
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func fitImageKeyPath() -> KeyPath<UIButton, UIImage?> {
        return \UIButton.currentBackgroundImage
    }
    //@IBInspectable 
    @objc open var backgroundImageRatioConstraintPrority:Float {
        get {
            return ratioConstraintPrority
        }
        set {
            ratioConstraintPrority = newValue
        }
    }
}
@available(iOS 15.0, *)
private var statusImagesHandle: UInt8 = 0
@available(iOS 15.0, *)
extension UIButton {
    public var statusImages:[UIControl.State.RawValue:UIImage] {
        get {
            guard let images = objc_getAssociatedObject(self, &statusImagesHandle) as? [UIControl.State.RawValue:UIImage] else {
                let images = [UIControl.State.RawValue:UIImage]()
                self.statusImages = images
                return images
            }
            return images
        }
        set {
            objc_setAssociatedObject(self, &statusImagesHandle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //@IBInspectable
    @objc public var selectedImage:UIImage? {
        get {
            return self.getStatusImage(for:.selected)
        }
        set {
            self.setStatusImage(for: .selected, image: newValue)
        }
    }
    //@IBInspectable
    @objc public var normalImage:UIImage? {
        get {
            return self.getStatusImage(for:.normal)
        }
        set {
            self.setStatusImage(for: .normal, image: newValue)
        }
    }
    //@IBInspectable
    @objc public var highlightedImage:UIImage? {
        get {
            return self.getStatusImage(for:.highlighted)
        }
        set {
            self.setStatusImage(for: .highlighted, image: newValue)
        }
    }
    @inlinable public func setupButtonConfigurationHandle() {
        self.configurationUpdateHandler = {
            button in
            button.configuration?.image = self.getStatusImage(for: button.state)
        }
    }
    @inlinable func getStatusImage(for state:UIControl.State) -> UIImage? {
        return self.statusImages[state.rawValue]
    }
    @inlinable func setStatusImage(for state:UIControl.State,image:UIImage?) {
        if let image = image {
            self.statusImages[state.rawValue] = image
        }
        else {
            self.statusImages.removeValue(forKey: state.rawValue)
            self.setupButtonConfigurationHandle()
        }
    }
}
