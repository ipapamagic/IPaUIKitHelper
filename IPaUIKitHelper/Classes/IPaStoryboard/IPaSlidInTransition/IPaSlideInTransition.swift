//
//  IPaTransitionSlideIn.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2021/7/2.
//

import UIKit
public enum IPaSlideInTransitionDirection:Int {
    case up = 0
    case down = 1
    case left = 2
    case right = 3
}
protocol IPaSlideInInfo
{
    var contentSize:CGSize { get }
    var coverColor:UIColor { get }
    var slideDirection:IPaSlideInTransitionDirection { get }
    var animationDuration:TimeInterval { get }
}
class IPaSlideInTransition: NSObject,UIViewControllerTransitioningDelegate,IPaSlideInInfo {
    var contentSize: CGSize = .zero
    var slideDirection: IPaSlideInTransitionDirection = .left
    var animationDuration: TimeInterval = 0.3
    var coverColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = IPaSlideInPresentationController(presentedViewController: presented,
                                                                     presenting: presenting,slideDelegate: self)
        
        return presentationController
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return IPaSlideInAnimator(isPresentation: true,  delegate: self)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return IPaSlideInAnimator(isPresentation: false,  delegate: self)
    }
}
