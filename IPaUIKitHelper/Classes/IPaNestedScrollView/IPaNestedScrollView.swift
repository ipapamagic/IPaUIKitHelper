//
//  IPaNestedScrollView.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2020/8/10.
//

import UIKit

open class IPaNestedScrollView: UIScrollView,UIGestureRecognizerDelegate {
    private var simultaneouslyOtherGesture:Bool = false
    weak var childScrollView:IPaNestedScrollViewInner? {
        didSet {
            if let childScrollView = childScrollView {
                let scrollView:UIScrollView = childScrollView.targetScrollView
                self.childContentOffsetObserver = scrollView.observe(\.contentOffset, options: [.new,.old], changeHandler: { (scrollView, value) in
                    self.refreshLockState()
                })                
            }
            else {
                self.childContentOffsetObserver = nil
            }
            
        }
    }
    open var childTargetRect:CGRect?
    var childEdgeInsets:UIEdgeInsets = .zero
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var childContentOffsetObserver:NSKeyValueObservation? {
        didSet {
            if let oldValue = oldValue {
                oldValue.invalidate()
            }
        }
    }
    var contentOffsetObserver:NSKeyValueObservation!
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.initialSetting()
    }
    public required init?(coder: NSCoder) {
        super.init(coder:coder)
        self.initialSetting()
    }
    
    func initialSetting() {
        self.simultaneouslyOtherGesture = true
        self.contentOffsetObserver = self.observe(\.contentOffset, options: [.new,.old], changeHandler: { (scrollView, value) in
            self.refreshLockState()
        })
        
        self.panGestureRecognizer.delegate = self
    }
    public func refreshLockState() {
        guard let childView = childScrollView?.targetScrollView else {
            return
        }
        let containerRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
        var childRect:CGRect
        if let targetRect = childTargetRect {
            childRect = targetRect
        }
        else {
            childRect = self.convert(childView.bounds, from: childView)
            childRect = childRect.inset(by: self.childEdgeInsets)
        }
        
        
        if containerRect.contains(childRect) {
            self.simultaneouslyOtherGesture = true
            childView.isScrollEnabled = true
            if (childView.contentOffset.x == 0 && self.contentOffset.x > 0) || (childView.contentOffset.y == 0 && self.contentOffset.y > 0) || (childView.contentOffset.x + childRect.width - self.childEdgeInsets.left == childRect.maxX && self.contentOffset.x + self.bounds.width < self.contentSize.width) || (childView.contentOffset.y + childRect.height - childEdgeInsets.top == childRect.maxY && self.contentOffset.y + self.bounds.height < self.contentSize.height) {
                self.isScrollEnabled = true
                childScrollView?.simultaneouslyOtherGesture = true
            }
            else {
                childScrollView?.simultaneouslyOtherGesture = false
                self.isScrollEnabled = false
//                let point = childRect.origin
//                if self.contentOffset != point {
//                    self.contentOffset = point
//                }
            }
            
        
            
            
        }
        else {
            childView.isScrollEnabled = false
            childScrollView?.simultaneouslyOtherGesture = false
            self.isScrollEnabled = true
            self.simultaneouslyOtherGesture = false
//            let x = (childRect.minX < self.contentOffset.x) ?  childView.contentSize.width - childView.bounds.width : 0
//
//            let y = (childRect.minY < self.contentOffset.y) ?  childView.contentSize.height - childView.bounds.height : 0
//            let point = CGPoint(x: x, y: y)
//            if point != childView.contentOffset {
//                childView.contentOffset = point
//            }
        }
      
    }
    
    open func register(_ scrollView:IPaNestedScrollViewInner,edgeInsets:UIEdgeInsets = .zero) {
        if let childScrollView = self.childScrollView ,childScrollView.targetScrollView == scrollView.targetScrollView {
            return
        }
        
        self.childScrollView = scrollView
        self.childScrollView?.simultaneouslyOtherGesture = true
        self.childEdgeInsets = edgeInsets
        self.refreshLockState()
        scrollView.targetScrollView.contentOffset = .zero
    }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return simultaneouslyOtherGesture
    }
}


