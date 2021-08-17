//
//  WKWebView+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/7.
//

import UIKit
import WebKit
import IPaLog
extension WKWebView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBInspectable open var isScrollEnabled: Bool {
        get {
            return self.scrollView.isScrollEnabled
        }
        set  {
            self.scrollView.isScrollEnabled = newValue
        }
    }
    @IBInspectable open var bounces: Bool {
        get {
            return self.scrollView.bounces
        }
        set  {
            self.scrollView.bounces = newValue
        }
    }
    
    
    open func post(_ request:URLRequest,encoding: String.Encoding = .utf8) {
        guard let bodyData = request.httpBody,let bodyString = String(data: bodyData, encoding: encoding),let urlString = request.url?.absoluteString else {
            return
        }
        let bodyParams = (bodyString as NSString).components(separatedBy: "&")
        var params = [String]()
        for param in bodyParams {
            let data = (param as NSString).components(separatedBy:"=")
            guard data.count == 2 else {
                continue
            }
            params.append("\"\(data[0])\":\"\(data[1])\"")
        }
        let paramsString = params.joined(separator: ",")
        let postSource = """
        function post(url, params) {
        var method = "post";
        var form = document.createElement("form");
        form.setAttribute("method", method);
        form.setAttribute("action", url);
        
        for(var key in params) {
        if(params.hasOwnProperty(key)) {
        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", key);
        hiddenField.setAttribute("value", params[key]);
        form.appendChild(hiddenField);
        }
        }
        document.body.appendChild(form);
        form.submit();
        }
        post('\(urlString)',{\(paramsString)});
        """
        self.evaluateJavaScript(postSource) { (result, error) in
            if let error = error {
                IPaLog("IPaDesignableWebView - post error: \(error)")
            }
        }
    }
}
extension WKWebView:IPaHasHTMLContent {
    public func loadHTMLString(_ string: String, baseURL: URL?,replacePtToPx:Bool) -> WKNavigation? {
        var content = string
        if replacePtToPx {
            content = self.replaceCSSPtToPx(with: string)
        }
        return self.loadHTMLString(content, baseURL: baseURL)
    }
}
//Javascript helper
extension WKWebView {
    @inlinable open func postJSMessage(with source:String,messageName:String,errorHandle: ((Error)->())? = nil) {
        self.evaluateJavaScript("window.webkit.messageHandlers.\(messageName).postMessage(\(source);") { (result, error) in
            if let error = error {
                errorHandle?(error)
            }
        }
    }
    @inlinable open func injectJS(_ source:String) {
        //UserScript object
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        //Content Controller object
        
        self.configuration.userContentController.addUserScript(script)
    }
    @inlinable open func injectOnLoadJS(_ handler:WKScriptMessageHandler,messageName:String) {
        let source = "window.addEventListener(\"load\", function () {window.webkit.messageHandlers.\(messageName).postMessage({});}, false); "
        self.injectJS(source)
        //Add message handler reference
        self.configuration.userContentController.add(handler, name: messageName)
    }
    @inlinable open func injectContentResizeJS(handler:WKScriptMessageHandler,messageName:String) {
        let source = "window.addEventListener(\"load\", function () {window.webkit.messageHandlers.\(messageName).postMessage({justLoaded:true,height: document.body.scrollHeight});}, false);  document.body.addEventListener( 'resize', incrementCounter); function incrementCounter() {window.webkit.messageHandlers.\(messageName).postMessage({height: document.body.scrollHeight});};"
        
        self.injectJS(source)
        
        //Add message handler reference
        self.configuration.userContentController.add(handler, name: messageName)
    }
    @inlinable open func textSizeJS(for ratio:Float) -> String {
        return "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust='\(ratio * 100)%'"
    }
    @inlinable open func setJSTextSizeAdjust(_ ratio:Float,complete:((Any?,Error?)->Void)? = nil) {
        self.evaluateJavaScript(self.textSizeJS(for:ratio), completionHandler: complete)
    }
    @inlinable open func injectTextSizeAdjust(_ ratio:Float) {
        self.injectJS(self.textSizeJS(for:ratio))
    }
    @inlinable open func injectFitContentJS() {
        //fit content size script
        let js = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width initial-scale=1'); document.getElementsByTagName('head')[0].appendChild(meta);"
        //Content Controller object
        self.injectJS(js)
        
    }
}