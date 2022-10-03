//
//  IPaNetworkState.swift
//  Pods
//
//  Created by IPa Chen on 2017/3/6.
//
//
import UIKit

open class IPaNetworkState: NSObject {
    static var networkCounter = 0
    static var isNetworkActivityIndicatorVisible:Bool {
        get {
            return UIApplication.shared.isNetworkActivityIndicatorVisible
        }
        set {
            if Thread.isMainThread {
                UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
            }
            else {
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = newValue
                }
            }
        }
    }
    @objc class public func startNetworking() {
        networkCounter += 1
        self.isNetworkActivityIndicatorVisible = true
        
    }
    @objc class public func endNetworking() {
        networkCounter -= 1
        if networkCounter <= 0 {
            networkCounter = 0
            self.isNetworkActivityIndicatorVisible = false
        }
    }
}
