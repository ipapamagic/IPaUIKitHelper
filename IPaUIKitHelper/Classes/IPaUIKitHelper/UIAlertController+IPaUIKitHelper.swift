//
//  UIAlertController+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/5/16.
//

import UIKit
class IPaTextFieldInputAction: UIAlertAction {
    @objc func alertTextFieldDidChange(_ sender: UITextField) {
        self.isEnabled = (sender.text?.count ?? 0) > 0
    }
}
extension UIAlertController {
    public class func presentAlertInput(from viewController:UIViewController = UIApplication.shared.rootViewController!,title:String?,message:String?,onAddTextField:((UITextField)->())? = nil,confirm:String,confirmAction:@escaping (String)->(),cancel:String? = nil,cancelAction:(()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = IPaTextFieldInputAction(title: confirm, style: .default, handler: { action in
            guard let textField = alertController.textFields?.first,let text = textField.text,text.count > 0 else {
                cancelAction?()
                return
            }
            confirmAction(text)
        })
        alertController.addAction(action)
        if let cancel = cancel {
            let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: { action in
                cancelAction?()
            })
            alertController.addAction(cancelAction)
        }
        alertController.addTextField { textField in
            onAddTextField?(textField)
            textField.addTarget(action, action: #selector(action.alertTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            action.alertTextFieldDidChange(textField)
        }
        
        viewController.present(alertController, animated: true)
        
    }
    public class func presentAlert(from viewController:UIViewController = UIApplication.shared.rootViewController!,title:String?,message:String?,confirm:String,confirmAction:@escaping ()->(),cancel:String? = nil,cancelAction:(()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: confirm, style: .default, handler: { action in
            confirmAction()
        })
        alertController.addAction(action)
        if let cancel = cancel {
            let cancelAction = UIAlertAction(title: cancel, style: .cancel, handler: { action in
                cancelAction?()
            })
            alertController.addAction(cancelAction)
        }
        viewController.present(alertController, animated: true)
    }

}
