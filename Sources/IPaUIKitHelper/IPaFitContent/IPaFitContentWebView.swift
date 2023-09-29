//
//  IPaFitContentWebView.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2019/1/2.
//

import UIKit
import WebKit

@objc public protocol IPaFitContentWebViewContainer {
    func onWebViewContentSizeUpdate(_ webView:IPaFitContentWebView)
}
// IPaWebViewOpenUrlHandler is for WKNavigationDelegate,that will use open url to open link
@available(iOSApplicationExtension, unavailable)
open class IPaWebViewOpenUrlHandler:NSObject,WKNavigationDelegate {
    public override init() {
        super.init()
    }
    
    @available(iOS 13.0, *)
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        
        decisionHandler(self.handleWebViewAction(navigationAction), preferences)
    }
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(self.handleWebViewAction(navigationAction))
    }
    private func handleWebViewAction(_ action:WKNavigationAction) -> WKNavigationActionPolicy {
        guard  action.navigationType == .linkActivated else {
            return .allow
        }
        let request = action.request
        guard let url = request.url else {
            return .allow
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        return .cancel
    }
}

extension UITableView:IPaFitContentWebViewContainer {
    public func onWebViewContentSizeUpdate(_ webView: IPaFitContentWebView) {
        self.headerViewFitContent()
        self.footerViewFitContent()
    }
    
}
//private var observerContext = 0
open class IPaFitContentWebView: WKWebView {
    fileprivate var contentHeight:CGFloat = 0 {
        didSet {
            guard self.heightConstraint.constant != contentHeight else{
                return
            }
            self.heightConstraint.constant = contentHeight
            self.invalidateIntrinsicContentSize()
            self.setNeedsLayout()
        }
    }
    @IBOutlet public var fitContentWebViewContainer:IPaFitContentWebViewContainer?
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
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        self.initialJSScript()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialJSScript()
    }
    open func initialJSScript() {
        self.configuration.userContentController.removeAllUserScripts()
        self.configuration.userContentController.removeScriptMessageHandler(forName: "sizeNotification")
        
        self.injectFitContentJS()
        self.injectContentResizeJS(handler: self, messageName: "sizeNotification")
        self.scrollView.isScrollEnabled = false
        self.scrollView.bounces = false
        self.scrollView.alwaysBounceHorizontal = false
        self.scrollView.alwaysBounceVertical = false
        
    }
   
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override open var intrinsicContentSize: CGSize {
        return CGSize(width:self.scrollView.contentSize.width,height:contentHeight)
        
    }
    open override func setJSTextSizeAdjust(_ ratio: Float, complete: ((Any?, Error?) -> Void)? = nil) {
        self.contentHeight = 1
        self.fitContentWebViewContainer?.onWebViewContentSizeUpdate(self)
        super.setJSTextSizeAdjust(ratio ,complete: complete)
    }
  

}

extension IPaFitContentWebView:WKScriptMessageHandler
{
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "sizeNotification":
            if let responseDict = message.body as? [String:Any],
               let height = responseDict["height"] as? CGFloat {
                self.contentHeight = height
                self.fitContentWebViewContainer?.onWebViewContentSizeUpdate(self)
            }
        default:
            break
        }
        
    }
}
