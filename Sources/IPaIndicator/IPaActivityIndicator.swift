//
//  IPaActivityIndicator.swift
//  IPaActivityIndicator
//
//  Created by IPa Chen on 2015/7/4.
//  Copyright (c) 2015年 A Magic Studio. All rights reserved.
//

import Foundation
import UIKit

open class IPaActivityIndicator: IPaIndicator {
    
    lazy var indicator:UIActivityIndicatorView = {
        
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style:.large)
        } else {
            // Fallback on earlier versions
            return UIActivityIndicatorView(style:.whiteLarge)
        }
        
        
        
    }()
    lazy var textLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    public override func initialSetting() {
        super.initialSetting()
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        indicatorBlackView.addSubview(indicator)
        indicatorBlackView.addSubview(textLabel)
        let viewDict = ["indicator":indicator,"textLabel":textLabel] as [String : Any]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[indicator]-15-[textLabel]-15-|", options: [], metrics: nil, views:viewDict)
        indicatorBlackView.addConstraints(constraints)
        constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-30@999-[indicator]-30@999-|", options: [], metrics: nil, views: viewDict)
        indicatorBlackView.addConstraints(constraints)
        var constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .centerX, relatedBy: .equal, toItem: textLabel, attribute: .centerX, multiplier: 1, constant: 0)
        indicatorBlackView.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: indicatorBlackView, attribute: .leading, multiplier: 1, constant: 8)
        indicatorBlackView.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: textLabel, attribute: .trailing, multiplier: 1, constant: 8)
        indicatorBlackView.addConstraint(constraint)
        textLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        indicator.startAnimating()
        
        
        indicatorBlackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(indicatorBlackView)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: indicatorBlackView, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        self.addConstraint(constraint)
        constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: indicatorBlackView, attribute: .trailing, multiplier: 1, constant: 16)
        self.addConstraint(constraint)
        
        
    }
     
    // MARK:static public function
    @discardableResult
    @objc open class func show(_ inView:UIView,text:String?) -> Self {
        let indicator = self.show(inView)
        if let text = text {
            indicator.textLabel.text = text
        }
        return indicator
    }
    
}
