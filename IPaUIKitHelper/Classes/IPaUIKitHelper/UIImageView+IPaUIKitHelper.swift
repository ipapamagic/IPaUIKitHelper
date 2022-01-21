//
//  UIImageView+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/27.
//

import UIKit
import AVKit
private var avAssetHandle: UInt8 = 0
extension UIImageView :IPaRatioFitImage {
    func fitImageKeyPath() -> KeyPath<UIImageView, UIImage?> {
        return \UIImageView.image
    }
    
    //@IBInspectable
    @objc public var imageRatioConstraintPrority:Float {
        get {
            return ratioConstraintPrority
        }
        set {
            ratioConstraintPrority = newValue
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var fitImage: UIImage? {
        return self.image
    }
    public func setPreview(of asset:AVAsset,time:CMTime=CMTime(seconds: 0, preferredTimescale: 600)) -> AVAssetImageGenerator {
        let generator = AVAssetImageGenerator(asset: asset)
        objc_setAssociatedObject(self, &avAssetHandle, generator, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        generator.generateCGImagesAsynchronously(forTimes: [NSValue(time:time)]) { _, image, _, _, _ in
            DispatchQueue.main.async {
                if generator.asset == asset,let image = image {
                
                    self.image = UIImage(cgImage: image)
                    objc_setAssociatedObject(self, &avAssetHandle, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                }
            }
        }
        return generator
    }
    public func cancelAssetPreviewGenerate() {
        guard let generator = objc_getAssociatedObject(self, &avAssetHandle) as? AVAssetImageGenerator else {
            return
        }
        generator.cancelAllCGImageGeneration()
    }
    
}
