//
//  IPaSlideInSubviewController.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/2/20.
//

import UIKit
import IPaUIKitHelper
public enum IPaSlideInSubViewDirection:Int {
    case up = 0
    case down = 1
    case left = 2
    case right = 3
}
public class IPaSlideInSubviewController: NSObject {
    public var slideDirection:IPaSlideInSubViewDirection = .down
    public var animationDuration:TimeInterval = 0.3
    var showConstraints = [NSLayoutConstraint]()
    var hideConstraints = [NSLayoutConstraint]()
    weak var source:UIViewController!
    weak var destination:UIViewController!
    private func prepare() {
        self.source.easyAddChild(self.destination) { view in
            let sourceView = self.source.view!
            
            
            sourceView.addSubview(view)
            switch self.slideDirection {
            case .up:
                sourceView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                sourceView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                let bottomConstraint = sourceView.topAnchor.constraint(equalTo: view.bottomAnchor)
                let topConstraint = sourceView.topAnchor.constraint(equalTo: view.topAnchor)
                self.showConstraints = [topConstraint]
                self.hideConstraints = [bottomConstraint]
                
            case .down:
                sourceView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                sourceView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                let bottomConstraint = sourceView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                let topConstraint = sourceView.bottomAnchor.constraint(equalTo: view.topAnchor)
                self.showConstraints = [bottomConstraint]
                self.hideConstraints = [topConstraint]
                
            case .left:
                let leadConstraint = sourceView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
                let trailingConstraint = sourceView.leadingAnchor.constraint(equalTo: view.trailingAnchor)
                sourceView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                sourceView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                self.showConstraints = [leadConstraint]
                self.hideConstraints = [trailingConstraint]
            case .right:
                let leadConstraint = sourceView.trailingAnchor.constraint(equalTo: view.leadingAnchor)
                let trailingConstraint = sourceView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                
                self.showConstraints = [trailingConstraint]
                self.hideConstraints = [leadConstraint]
            }
            
        }
        
        
    }
    open func showTransition() {
        
        self.destination.view.translatesAutoresizingMaskIntoConstraints = false
        self.prepare()
        for constraint in self.showConstraints {
            constraint.isActive = false
        }
        for constraint in self.hideConstraints {
            constraint.isActive = true
        }
        source.view.layoutIfNeeded()
        
        for constraint in self.hideConstraints {
            constraint.isActive = false
        }
        for constraint in self.showConstraints {
            constraint.isActive = true
        }
        
        UIView.animate(withDuration: self.animationDuration) {
            self.source.view.layoutIfNeeded() 
        }
        
    }
    @objc public func dismissTransition() {
        for constraint in self.showConstraints {
            constraint.isActive = false
        }
        for constraint in self.hideConstraints {
            constraint.isActive = true
        }
        UIView.animate(withDuration: self.animationDuration,animations: {
            self.source.view.layoutIfNeeded()
        }) { finished in
            self.destination.easyRemoveFromParent()
            
        }
    }
    
    public init(_ source:UIViewController,destination:UIViewController) {
        self.source = source
        self.destination = destination
        
        
    }
    
}
