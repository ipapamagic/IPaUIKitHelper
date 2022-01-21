//
//  UIView+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/7.
//

import UIKit
import IPaImageTool
import ObjectiveC

private var shadowSpreadHandle: UInt8 = 0
private var roundCornerHandle: UInt8 = 0
private var borderHandle: UInt8 = 0
private var sizeObserverHandle: UInt8 = 0
extension UIView {
    //@IBInspectable 
    @objc public var maskToBounds:Bool {
        get {
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
    //@IBInspectable 
    @objc public var cornerRadius:CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    //@IBInspectable 
    @objc public var borderWidth:CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    //@IBInspectable 
    @objc open var borderColor:UIColor? {
        get {
            self.layer.borderUIColor
        }
        set {
            self.layer.borderUIColor = newValue
        }
    }
    //@IBInspectable 
    @objc public var shadowBlur:CGFloat {
        get {
            return self.shadowRadius * 2
        }
        set {
            self.shadowRadius = newValue * 0.5
        }
    }
    //@IBInspectable 
    @objc public var shadowColor:UIColor? {
        get {
            if let color = self.layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    //@IBInspectable 
    @objc public var shadowSpread:CGFloat {
        get {
            return objc_getAssociatedObject(self, &shadowSpreadHandle) as? CGFloat ?? 0
        }
        set {
            objc_setAssociatedObject(self, &shadowSpreadHandle, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if newValue == 0 {
                self.layer.shadowPath = nil
            }
            else {
                objc_setAssociatedObject(self, &shadowSpreadHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                        
                let dx = -newValue
                let rect = bounds.insetBy(dx: dx, dy: dx)
                
                self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
                
                self.layer.contentsScale = UIScreen.main.scale
                self.addSizeObserver()
            }
        }
    }
    //@IBInspectable 
    @objc public var shadowRadius:CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    //@IBInspectable 
    @objc public var shadowOffset:CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    //@IBInspectable 
    @objc public var shadowOpacity:Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    @discardableResult
    public func applyGradient(colours: [UIColor],startPoint:CGPoint,endPoint:CGPoint,locations: [NSNumber]? = nil) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    open func setBackgroundImage(_ image:UIImage,mode:UIView.ContentMode) {
        var modifyImage:UIImage
        
        switch mode {
        case .bottom:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:(self.bounds.size.width  - image.size.width) * 0.5   , y: self.bounds.size.height - image.size.height))
                
            }) ?? image
        case.bottomLeft:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:0, y: self.bounds.size.height - image.size.height))
                
            }) ?? image
        case .bottomRight:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:self.bounds.size.width - image.size.width, y: self.bounds.size.height - image.size.height))
                
            }) ?? image
        case .center:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:(self.bounds.size.width  - image.size.width) * 0.5   , y: (self.bounds.size.height - image.size.height) * 0.5))
                
            }) ?? image
        case .left:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:self.bounds.size.width - image.size.width    , y: (self.bounds.size.height - image.size.height) * 0.5))
                
            }) ?? image
        case .right:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:0 , y: (self.bounds.size.height - image.size.height) * 0.5))
                
            }) ?? image
        case .redraw:
            modifyImage = image
        case .scaleAspectFill:
            modifyImage = image.image(aspectFillSize:self.bounds.size)
        case .scaleAspectFit:
            modifyImage = image.image(fitSize:self.bounds.size)
        case .scaleToFill:
            modifyImage = image.image(size: self.bounds.size)
        case .top:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:(self.bounds.size.width - image.size.width) * 0.5  , y: 0))
                
            }) ?? image
        case .topRight:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:self.bounds.size.width - image.size.width  , y: 0))
                
            }) ?? image
        case .topLeft:
            modifyImage = UIImage.createImage(self.bounds.size,operation:{
                context in
                
                image.draw(at: CGPoint(x:0  , y: 0))
                
            }) ?? image
        @unknown default:
            modifyImage = image
        }
        
        

        self.backgroundColor = UIColor(patternImage: modifyImage)
            
    }
    open func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let cornerMask = objc_getAssociatedObject(self, &roundCornerHandle) as? CAShapeLayer ?? CAShapeLayer()

        cornerMask.path = path.cgPath
        layer.mask = cornerMask
        
        objc_setAssociatedObject(self, &roundCornerHandle, cornerMask, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        self.addSizeObserver()
    }
    func addSizeObserver() {
        if let _ = objc_getAssociatedObject(self, &sizeObserverHandle) {
            return
        }
        let sizeObserver = self.observe(\.bounds) { view, value in
            if let cornerMaskLayer = objc_getAssociatedObject(self, &roundCornerHandle) as? CAShapeLayer {
                cornerMaskLayer.bounds = view.bounds
            }
            if let (_,edges,width,color) = objc_getAssociatedObject(self, &borderHandle) as? (CAShapeLayer,[UIRectEdge],CGFloat,UIColor) {
                self.setBorder(edges, width: width, color: color)
            }
            if let shadowSpread = objc_getAssociatedObject(self, &shadowSpreadHandle) as? CGFloat {
                self.shadowSpread = shadowSpread
            }
        }
        objc_setAssociatedObject(self, &sizeObserverHandle, sizeObserver, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    @inlinable open func setBorder(_ edge:UIRectEdge,width:CGFloat,color:UIColor)  {
        
        self.setBorder([edge], width: width, color: color)
        
    }
    open func setBorder(_ edges:[UIRectEdge],width:CGFloat,color:UIColor) {
        
        var path = UIBezierPath()
        let vSize = CGSize(width: self.bounds.width, height: 1)
        let hSize = CGSize(width: 1, height: self.bounds.height)
        
        func addPath(_ edge:UIRectEdge,path:UIBezierPath) -> UIBezierPath {
            switch edge {
            case .top:
                let rect = UIBezierPath(rect: CGRect(origin: .zero, size: vSize))
                path.append(rect)
            case .bottom:
                let rect = UIBezierPath(rect: CGRect(origin: CGPoint(x: 0, y: self.bounds.height - width), size: vSize))
                path.append(rect)
            case .left:
                let rect = UIBezierPath(rect: CGRect(origin: .zero, size: hSize))
                path.append(rect)
            case .right:
                let rect = UIBezierPath(rect: CGRect(origin: CGPoint(x: self.bounds.width - width, y: 0), size: hSize))
                path.append(rect)
            default:
                break
            }
            return path
        }
        
        
        for edge in edges {
            if edge == .all {
                for e in [UIRectEdge.top,UIRectEdge.bottom,UIRectEdge.left,UIRectEdge.right] {
                    path = addPath(e, path: path)
                }
            }
            else {
                path = addPath(edge, path: path)
            }
        }
        
        let (borderShapeLayer,_,_,_) = objc_getAssociatedObject(self, &borderHandle) as? (CAShapeLayer,[UIRectEdge],CGFloat,UIColor) ?? (CAShapeLayer(),[UIRectEdge](),0,.black)
        
        objc_setAssociatedObject(self, &borderHandle, (borderShapeLayer,edges,width,color), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        borderShapeLayer.path = path.cgPath
        borderShapeLayer.fillColor = color.cgColor
//        borderShapeLayer.bounds = self.layer.bounds
        self.layer.addSublayer(borderShapeLayer)
        self.addSizeObserver()
        
    }
    open func addSubview(_ view:UIView,edgeInsects:UIEdgeInsets) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsects.top).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: edgeInsects.bottom).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsects.left).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: edgeInsects.right).isActive = true
        
    }
    open func addSubviewToFill(_ view:UIView) {
        self.addSubview(view,edgeInsects: .zero)
    }
}
