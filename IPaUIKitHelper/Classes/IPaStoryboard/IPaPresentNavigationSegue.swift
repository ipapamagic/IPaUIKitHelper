//
//  IPaPresentNavigationSegue.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/7/13.
//

import UIKit

open class IPaPresentNavigationSegue: UIStoryboardSegue {
    open func createNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: self.destination)
    }
    override open func perform() {
        self.source.present(self.createNavigationController(), animated: true)
    }
}
