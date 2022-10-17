//
//  IPaToast.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/6/12.
//

import UIKit
import IPaUIKit
import IPaUIKitHelper
open class IPaToast: UIView {
    public lazy var toastLabel:IPaUILabel = {
        let label = IPaUILabel()
        label.bottomInset = 8
        label.leftInset = 16
        label.topInset = 8
        label.rightInset = 16
        label.numberOfLines = 0
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
//        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.addSubviewToFill(label)
        return label
    }()
    var bottomConstraint:NSLayoutConstraint?
    public var toastText:String? {
        get {
            return self.toastLabel.text
        }
        set {
            self.toastLabel.text = newValue
            self.toastLabel.sizeToFit()
            self.cornerRadius = self.toastLabel.bounds.height * 0.5
            
        }
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black.withAlphaComponent(0.6)
        self.clipsToBounds = true
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    public func toast(_ text:String,in view:UIView,duration:TimeInterval = 2) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0
        view.addSubview(self)
        self.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16).isActive = true
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.toastText = text
        self.bottomConstraint = self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: self.toastLabel.bounds.height)
        bottomConstraint?.isActive = true
        view.layoutIfNeeded()
        self.bottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(rawValue: 0),animations:  {
            self.alpha = 1
            view.layoutIfNeeded()
        }, completion: { finished in
            Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(self.onDismiss(_:)), userInfo: nil, repeats: false)
            
        })
    }
    @objc func onDismiss(_ sender:Any) {
        self.bottomConstraint?.constant = self.bounds.height
        
        UIView.animate(withDuration: 0.3,animations:  {
            self.alpha = 0
            
            self.superview?.layoutIfNeeded()
        }, completion: { finished in
            
            self.removeFromSuperview()
        })
    }
    public class func toast(_ text:String,in view:UIView,backgroundColor:UIColor = .black.withAlphaComponent(0.6),textColor:UIColor = .white,duration:TimeInterval = 2) {
        let toastView = IPaToast(frame: .zero)
        toastView.backgroundColor = backgroundColor
        toastView.toastLabel.textColor = textColor
        toastView.toast(text, in: view, duration: duration)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
