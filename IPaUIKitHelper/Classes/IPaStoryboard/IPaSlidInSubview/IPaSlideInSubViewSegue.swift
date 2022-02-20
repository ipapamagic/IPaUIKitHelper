//
//  IPaSlideInTransitioningSegue.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2021/7/2.
//

import UIKit
import ObjectiveC
//@IBDesignable

open class IPaSlideInSubViewSegue: UIStoryboardSegue {
    
    public lazy var slideInController:IPaSlideInSubviewController = {
        let controller = IPaSlideInSubviewController(self.source, destination: self.destination)

        return controller
    }()
    override open func perform() {
        
        
        self.slideInController.showTransition()
        
        if let destination = self.destination as? IPaTransitionActor {
            destination.slideInController = self.slideInController
        }
    }
}
