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
        let navigationController = self.createNavigationController()
        navigationController.modalPresentationStyle = self.destination.modalPresentationStyle
        navigationController.modalTransitionStyle = self.destination.modalTransitionStyle
        self.source.present(navigationController, animated: true)
    }
}
