//
//  IPaProgressObservable.swift
//  IPaIndicator
//
//  Created by IPa Chen on 2020/4/19.
//

import UIKit
import Combine
import IPaDownloadManager
import IPaURLResourceUI

@available(iOS 13.0, *)
extension IPaProgressIndicator {
   
    
}

@available(iOS 13.0, *)
public protocol IPaProgressObservable: NSObject {
    func progressPublisher() -> AnyPublisher<Double,Never>
    
}
@available(iOS 13.0, *)
extension IPaURLRequestTaskOperation:IPaProgressObservable {
    
    public func progressPublisher() -> AnyPublisher<Double,Never> {
        return self.publisher(for: \.progress).eraseToAnyPublisher()
    }
    
}
@available(iOS 13.0, *)
extension IPaDownloadOperation:IPaProgressObservable {
    
    public func progressPublisher() -> AnyPublisher<Double,Never> {
        return self.publisher(for: \.progress).eraseToAnyPublisher()
    }
    
}
