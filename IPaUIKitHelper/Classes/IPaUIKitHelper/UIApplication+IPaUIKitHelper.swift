//
//  UIApplication+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/5/16.
//

import UIKit

extension UIApplication {
    var mainScene:UIWindowScene? {
        get {
            if let scene = self.connectedScenes
                .filter({$0.activationState == .foregroundActive}).first {
                return scene as? UIWindowScene
            }
            else if let scene = self.connectedScenes
                .filter({$0.activationState == .foregroundInactive}).first {
                return scene as? UIWindowScene
            }
            return self.connectedScenes.filter({$0 is UIWindowScene}).first as? UIWindowScene
            
        }
    }
    public var mainWindow:UIWindow? {
        get {
            return self.mainScene?.windows
                    .filter({$0.isKeyWindow}).first
        }
    }
    public var rootViewController:UIViewController? {
        return self.mainWindow?.rootViewController
    }
}
