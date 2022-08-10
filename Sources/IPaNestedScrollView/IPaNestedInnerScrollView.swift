//
//  IPaDesignableScrollView.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2020/6/10.
//

import UIKit
import WebKit
public protocol IPaNestedScrollViewInner:UIGestureRecognizerDelegate  {
    
    var targetScrollView:UIScrollView {get}
    var simultaneouslyOtherGesture:Bool { get set}
}


open class IPaNestedInnerScrollView: UIScrollView  ,IPaNestedScrollViewInner {
    public var simultaneouslyOtherGesture:Bool = false
    public var targetScrollView:UIScrollView {
        get {
            return self
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return simultaneouslyOtherGesture
    }
}

open class IPaNestedInnerTableView:UITableView ,IPaNestedScrollViewInner {
    public var simultaneouslyOtherGesture:Bool = false
    public var targetScrollView:UIScrollView {
        get {
            return self
        }
    }
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame,style: style)
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return simultaneouslyOtherGesture
    }
}
open class IPaNestedInnerWebView:WKWebView,IPaNestedScrollViewInner {
    public var simultaneouslyOtherGesture:Bool = false
    public var targetScrollView:UIScrollView {
        get {
            return self.scrollView
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return simultaneouslyOtherGesture
    }
}
