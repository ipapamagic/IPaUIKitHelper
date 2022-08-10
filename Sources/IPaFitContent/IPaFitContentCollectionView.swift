//
//  IPaFitContentCollectionView.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2020/11/27.
//

import UIKit

open class IPaFitContentCollectionView: UICollectionView {
    fileprivate var scrollViewObserver:Any?
    fileprivate var contentHeight:CGFloat = 0 {
        didSet {
            guard self.heightConstraint.constant != contentHeight else{
                return
            }
            self.invalidateIntrinsicContentSize()
            self.heightConstraint.constant = contentHeight
            self.superview?.layoutIfNeeded()
        }
    }
    lazy var heightConstraint:NSLayoutConstraint = {
        let constraint = self.heightAnchor.constraint(equalToConstant: self.contentHeight)
        constraint.priority = UILayoutPriority(rawValue: 999)
        constraint.isActive = true
        
        return constraint
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.initFitContent()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initFitContent()
    }
    fileprivate func initFitContent() {
        scrollViewObserver =
            self.observe(\.contentSize, options: [.new], changeHandler: {
             scrollView, change in
            self.contentHeight = self.contentSize.height
        })
    }
    deinit {
        self.scrollViewObserver = nil
    }
    override open var intrinsicContentSize: CGSize {
        return CGSize(width:self.contentSize.width , height: self.contentHeight)
    }
    
    open override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.superview?.layoutIfNeeded()
    }
}
