//
//  IPaCircleLayer.swift
//  Pods
//
//  Created by IPa Chen on 2017/6/26.
//
//

import UIKit
import QuartzCore
class IPaRoudProgressLayer: CALayer {
    var startAngle:CGFloat = CGFloat.pi * -0.5
    var endAngle:CGFloat = CGFloat.pi * 1.5
    var progressColor:CGColor = UIColor.white.cgColor
    var progressBackColor:CGColor = UIColor.lightGray.cgColor
    var lineWidth:CGFloat = 5.0
    @NSManaged var progress:CGFloat
    
    override init() {
        super.init()
    }
    override init(layer: Any) {
        super.init(layer: layer)
        if let circleLayer = layer as? IPaRoudProgressLayer {
            self.startAngle = circleLayer.startAngle
            self.endAngle = circleLayer.endAngle
            self.progressColor = circleLayer.progressColor
            self.progressBackColor = circleLayer.progressBackColor
            self.lineWidth = circleLayer.lineWidth
            self.progress = circleLayer.progress
            
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    open override class func needsDisplay(forKey key: String) -> Bool
    {
//        if key == "startAngle" || key == "endAngle" || key == "progressColor" || key == "lineWidth" || key == "progressBackColor" || key == "progress" {
//            return true
//        }
        if key == "progress" {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        //Doc from apple
        //The clockwise parameter determines the direction in which the arc is created; the actual direction of the final path is dependent on the current transformation matrix of the graphics context. In a flipped coordinate system (the default for UIView drawing methods in iOS), specifying a clockwise arc results in a counterclockwise arc after the transformation is applied.
        
        
        
        let halfLineWidth = self.lineWidth * 0.5
        let radius = min(self.bounds.midX,self.bounds.midY) - halfLineWidth
        let drawCenter = CGPoint(x:self.bounds.midX,y:self.bounds.midY)
        ctx.setLineWidth(self.lineWidth)
        ctx.setStrokeColor(self.progressBackColor)
        ctx.addArc(center: drawCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        ctx.strokePath()
        ctx.setStrokeColor(self.progressColor)
        let progressEndAngle = (endAngle - startAngle) * progress + startAngle
        ctx.addArc(center: drawCenter, radius: radius, startAngle: startAngle, endAngle:progressEndAngle , clockwise: false)
        ctx.strokePath()
        
        if progress > 0 {
            ctx.setFillColor(self.progressColor)
            self.drawPoint(in: ctx, at: startAngle,halfLineWidth:halfLineWidth,radius:radius)
            self.drawPoint(in: ctx, at: progressEndAngle,halfLineWidth:halfLineWidth,radius:radius)
            ctx.fillPath()
        }
        
    }
    fileprivate func drawPoint(in ctx: CGContext, at angle:CGFloat,halfLineWidth:CGFloat,radius:CGFloat)
    {
        
        let x = cos(angle) * radius + self.bounds.midX
        let y = sin(angle) * radius + self.bounds.midY
        ctx.addEllipse(in: CGRect(x: x - halfLineWidth, y: y - halfLineWidth, width: self.lineWidth, height: self.lineWidth))
        
    }
    
    override func action(forKey event: String) -> CAAction? {
        if event == "progress" {
            if let animation = super.action(forKey: "backgroundColor") as? CABasicAnimation
            {
                animation.keyPath = event
                animation.fromValue = self.presentation()?.value(forKey:event)
                animation.toValue = nil
                return animation
            }
            else {
                setNeedsDisplay()
                return nil
            }
        }
        return super.action(forKey: event)
    }
    
}
