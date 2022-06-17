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
            guard let windows = self.mainScene?.windows else {
                return nil
            }
            return windows
                .first(where:{$0.isKeyWindow}) ?? windows.first
        }
    }
    public var rootViewController:UIViewController? {
        get {
            return self.mainWindow?.rootViewController
        }
        set {
            self.mainWindow?.rootViewController = newValue
        }
    }
}
