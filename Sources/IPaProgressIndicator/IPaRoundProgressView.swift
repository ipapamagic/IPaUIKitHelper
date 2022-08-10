
//
//  IPaRoundProgressView.swift
//  Pods
//
//  Created by IPa Chen on 2017/6/25.
//
//

import UIKit
import QuartzCore

open class IPaRoundProgressView: UIView {
    override open class var layerClass: AnyClass {
        get {
            return IPaRoudProgressLayer.self
        }
    }
    var progressLayer:IPaRoudProgressLayer {
        get {
            return self.layer as! IPaRoudProgressLayer
        }
    }
    @IBInspectable open var progressBackColor:UIColor = UIColor.lightGray {
        didSet {
            
            progressLayer.progressBackColor = self.progressBackColor.cgColor
            self.layer.setNeedsDisplay()
        }
    }
    @IBInspectable open var progressColor:UIColor = UIColor.white {
        didSet {
            progressLayer.progressColor = self.progressColor.cgColor
            self.layer.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var progress:CGFloat {
        get {
            return progressLayer.progress
        }
        set {
            progressLayer.progress = newValue
            
            self.layer.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var lineWidth:CGFloat = 5 {
        didSet {
            progressLayer.lineWidth = lineWidth
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}
