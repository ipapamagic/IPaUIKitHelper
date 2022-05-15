//
//  UIApplication+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/5/16.
//

import UIKit

extension UIApplication {
    public var mainWindow:UIWindow? {
        get {
            return self.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                    .filter({$0.isKeyWindow}).first
        }
    }
    public var rootViewController:UIViewController? {
        return self.mainWindow?.rootViewController
    }
}
