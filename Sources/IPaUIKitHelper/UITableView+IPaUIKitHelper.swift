//
//  UITableView+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/7.
//

import UIKit

extension UITableView {
    public func headerViewFitContent() {
        guard let headerView = self.tableHeaderView else {
            return
        }
        let fittingSize = CGSize(width: self.bounds.width , height: 0)
        let size = headerView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        headerView.frame = CGRect(origin: .zero, size: size)
        self.tableHeaderView = headerView
    }
    public func footerViewFitContent() {
        guard let footerView = self.tableFooterView else {
            return
        }
        let fittingSize = CGSize(width: self.bounds.width , height: 0)
        let size = footerView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        footerView.frame = CGRect(origin: .zero, size: size)
        self.tableFooterView = footerView
    }
    public func getCellIndexPath(contain view:UIView) -> IndexPath? {
        var cell:UIView? = view
        repeat {
            cell = cell?.superview
            if cell == nil {
                return nil
            }
            else if let cell = cell as? UITableViewCell,let indexPath = self.indexPath(for: cell) {
                return indexPath
            }
            
        }while true
    }
}
