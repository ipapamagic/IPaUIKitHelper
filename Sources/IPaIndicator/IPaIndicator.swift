//
//  IPaIndicator.swift
//  Pods
//
//  Created by IPa Chen on 2017/6/24.
//
//

import UIKit
@objc protocol IPaIndicatorProtocol {
    
}
@objc open class IPaIndicator: UIView {
    public private (set) lazy var indicatorBlackView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    public var backgroundView:UIView {
        get {
            return indicatorBlackView
        }
    }
    var counter = 1
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var widthConstraint:NSLayoutConstraint?
    open var preferIndicatorWidth:CGFloat? {
        get {
            if let widthConstraint = widthConstraint {
                return widthConstraint.constant
            }
            return nil
        }
        set {
            guard let newValue = newValue else {
                if let widthConstraint = widthConstraint {
                    indicatorBlackView.removeConstraint(widthConstraint)
                }
                return
            }
            if let widthConstraint = widthConstraint {
                widthConstraint.constant = newValue
                self.setNeedsDisplay()
            }
            else {
                widthConstraint = indicatorBlackView.widthAnchor.constraint(equalToConstant: newValue)
                widthConstraint?.isActive = true
            }
        }
    }
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        initialSetting()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialSetting()
    }
    open func initialSetting() {
        isUserInteractionEnabled = true
        backgroundColor = UIColor.clear
        indicatorBlackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        indicatorBlackView.layer.cornerRadius = 10
        indicatorBlackView.clipsToBounds = true
        
        
        indicatorBlackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicatorBlackView)
        var constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: indicatorBlackView, attribute: .trailing, multiplier: 1, constant: 16)
        self.addConstraint(constraint)
        
        
    }
    static func getActualInView(_ view:UIView) -> UIView {
        var actualInView = view
        while (actualInView is UITableView) {
            if let inSuperView = actualInView.superview {
                actualInView = inSuperView
            }
            else {
                return actualInView
            }
        }
        return actualInView
    }
    fileprivate class func getCurrentIndicator<T>(with view:UIView,type:T.Type) -> T? {
        let indicator = view.subviews.first { (subView) -> Bool in
            return Bool(subView is T)
        } as? T
        return indicator
    }
    fileprivate class func doShow(_ indicator:IPaIndicator, inView:UIView) {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        inView.addSubview(indicator)
        
        
        let viewsDict:[String:UIView] = ["view": indicator]
        inView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",options:[],metrics:nil,views:viewsDict))
        inView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",options:[],metrics:nil,views:viewsDict))
        
        
    }
    class func hideIndicator(_ indicator:IPaIndicator) {
        indicator.counter -= 1
        if indicator.counter <= 0 {
            indicator.removeFromSuperview()
        }
    }
    fileprivate class func doHide(_ fromView:UIView) {
        let actualFromView = getActualInView(fromView)
        guard let indicator = getCurrentIndicator(with: actualFromView,type:self) else {
            return
        }
        self.hideIndicator(indicator)
    }
    @discardableResult
    @objc open class func show(_ inView:UIView) -> Self {
        let actualInView = getActualInView(inView)
        if let indiator = getCurrentIndicator(with: actualInView,type:self) {
            indiator.counter += 1
            return indiator
        }
        
        let indicator = self.init(frame:actualInView.bounds)
//        if Thread.isMainThread {
//            doShow(indicator, inView: actualInView)
//        }
//        else {
//            DispatchQueue.main.async(execute: {
//
//                doShow(indicator, inView: actualInView)
//            })
//        }
        doShow(indicator, inView: actualInView)
        return indicator
    }
    @objc open class func hide(_ fromView:UIView) {
//        if Thread.isMainThread {
//            doHide(fromView)
//        }
//        else {
//            DispatchQueue.main.async(execute: {
//                doHide(fromView)
//                
//            })
//        }

        doHide(fromView)
    }
}
