//
//  IPaReplaceRootSegue.swift
//  Pods
//
//  Created by IPa Chen on 2017/5/2.
//
//

import UIKit
@available(iOSApplicationExtension, unavailable)
open class IPaReplaceRootSegue: UIStoryboardSegue {
    override open func perform() {
        let window = UIApplication.shared.mainWindow
        
        guard let oldVC = window?.rootViewController else {
            window?.rootViewController = self.destination
            return;
        }
        guard let snapshot = oldVC.view?.snapshotView(afterScreenUpdates: true) else {
            window?.rootViewController = self.destination
            return
        }
        self.destination.view.addSubview(snapshot)
        window?.rootViewController = self.destination
        
        UIView.animate(withDuration: 0.5, animations: {
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
            finished in
            snapshot.removeFromSuperview()
        })
    }
}
