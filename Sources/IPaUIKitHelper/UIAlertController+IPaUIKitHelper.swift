//
//  UIAlertController+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/5/16.
//

import UIKit
@available(iOSApplicationExtension, unavailable)
class IPaTextFieldInputAction: UIAlertAction {
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        self.isEnabled = (sender.text?.count ?? 0) > 0
    }
}
@available(iOSApplicationExtension, unavailable)
extension UIAlertController {
    public class func presentAlertInput(from viewController:UIViewController = UIApplication.shared.rootViewController!,title:String?,message:String?,onAddTextField:((UITextField)->())? = nil,confirm:String,confirmStyle:UIAlertAction.Style = .default ,confirmAction:@escaping (String)->(),cancel:String? = nil,cancelStyle:UIAlertAction.Style = .cancel,cancelAction:(()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = IPaTextFieldInputAction(title: confirm, style: confirmStyle, handler: { action in
            guard let textField = alertController.textFields?.first,let text = textField.text,text.count > 0 else {
                cancelAction?()
                return
            }
            confirmAction(text)
        })
        alertController.addAction(action)
        if let cancel = cancel {
            alertController.addAction(title: cancel,style: cancelStyle) { action in
                cancelAction?()
            }
        }
        alertController.addTextField { textField in
            onAddTextField?(textField)
            textField.addTarget(action, action: #selector(action.alertTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            action.alertTextFieldDidChange(textField)
        }
        
        viewController.present(alertController, animated: true)
        
    }
    public class func presentAlert(from viewController:UIViewController? = nil,title:String?,message:String?,confirm:String,confirmStyle:UIAlertAction.Style = .default,confirmAction:(()->())? = nil,cancel:String? = nil,cancelStyle:UIAlertAction.Style = .cancel, cancelAction:(()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(title: confirm,style: confirmStyle) { action in
            confirmAction?()
        }
        if let cancel = cancel {
            alertController.addAction(title: cancel,style: cancelStyle) { action in
                cancelAction?()
            }
        }
        var presentVC = viewController ?? UIApplication.shared.rootViewController!
        while let presentedVC = presentVC.presentedViewController {
            presentVC = presentedVC
        }
        presentVC.present(alertController, animated: true)
    }
    
    @inlinable public func addAction(title:String,style:UIAlertAction.Style = .default,handler:((UIAlertAction)->())? = nil) {
        self.addAction(UIAlertAction(title: title, style: style, handler:handler))
    }
}
