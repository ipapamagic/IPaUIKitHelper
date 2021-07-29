//
//  UICollectionView.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/7.
//

import UIKit

extension UICollectionView {
    open func getCellIndexPath(contain view:UIView) -> IndexPath? {
        var cell:UIView? = view
        repeat {
            cell = cell?.superview
            if cell == nil {
                return nil
            }
            else if let cell = cell as? UICollectionViewCell,let indexPath = self.indexPath(for: cell) {
                return indexPath
            }
            
        }while true
    }
}
