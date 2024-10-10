//
//  UIViewController+IPaKeyboardObserber.swift
//  IPaKeyboardObserver
//
//  Created by IPa Chen on 2019/4/20.
//

import UIKit
private var keyboardDelegateHandle: UInt8 = 0
class IPaKeyboardTapDelegation:NSObject,UIGestureRecognizerDelegate {
    static var shared = IPaKeyboardTapDelegation()
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let isControllTapped = (touch.view is UIControl) || (touch.view is UIKeyInput)
        return !isControllTapped
    }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
public extension UIViewController {
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    fileprivate func _findAllTextInputViews(in view: UIView) -> [UIView]? {
        var textInputViews = [UIView]()
        for subview in view.subviews {
            if subview is UITextView || subview is UITextField {
                textInputViews.append(subview)
            } else {
                if let nestedTextInputViews = _findAllTextInputViews(in: subview) {
                    textInputViews.append(contentsOf: nestedTextInputViews)
                }
            }
        }
        return textInputViews.isEmpty ? nil : textInputViews
    }
    fileprivate func _getKeyboardObserverView() -> UIScrollView? {
        
        guard let firstScrollView = self.view.subviews.first(where: { (subView) -> Bool in
            return Bool(subView is UIScrollView)
        }) else {
            return nil
        }
        return firstScrollView as? UIScrollView
    }
    @objc func addTapToCloseKeyboard(_ targetView:UIView? = nil) {
        var targetView = targetView
        if targetView == nil {
            targetView = self._getKeyboardObserverView() ?? self.view
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.onTapToDismissKeyboard(_:)))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = IPaKeyboardTapDelegation.shared
        targetView!.addGestureRecognizer(tapGesture)
        if let allTextInputViews = _findAllTextInputViews(in: targetView!) {
            for textInputView in allTextInputViews {
                // require
                guard let recognizers = textInputView.gestureRecognizers else {
                    continue
                }
                for recognizer in recognizers {
                    tapGesture.require(toFail: recognizer)
                }
                
            }
        }
    }
    @objc func onTapToDismissKeyboard(_ sender:Any) {
        self.view.endEditing(true)
    }
    @objc func addKeyboardObserver() {
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        nc.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func removeKeyboardObserver() {
        
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//        nc.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //MARK: Keyboard notification
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo,let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
           else {
               return
           }

        let keyboardFrameInView = view.convert(keyboardFrame, from: nil)
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom)
        let intersection = safeAreaFrame.intersection(keyboardFrameInView)

        let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
        let animationDuration: TimeInterval = (keyboardAnimationDuration as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
           let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)

        UIView.animate(withDuration: animationDuration,
                          delay: 0,
                          options: animationCurve,
                          animations: {
               self.additionalSafeAreaInsets.bottom = intersection.height
               self.view.layoutIfNeeded()
           }, completion: nil)
        
        
       
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let userInfo = notification.userInfo!
        var animationDuration:TimeInterval = 0
        let value = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSValue
        value.getValue(&animationDuration)

        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded();
        }
    }

}

