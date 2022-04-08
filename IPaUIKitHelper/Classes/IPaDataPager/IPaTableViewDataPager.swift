//
//  IPaTableViewDataPager.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/4/5.
//

import UIKit

open class IPaTableViewDataPager<SectionIdentifierType,ItemIdentifierType>: IPaDataPager<SectionIdentifierType,ItemIdentifierType,UITableView,UITableViewCell> where SectionIdentifierType:Hashable,ItemIdentifierType:Hashable,ItemIdentifierType:IPaDataPagerHasLoadType {
    public weak var dataSource:UITableViewDiffableDataSource<SectionIdentifierType,ItemIdentifierType>!
    
    public init(_ dataSource:UITableViewDiffableDataSource<SectionIdentifierType,ItemIdentifierType>,section:SectionIdentifierType) {
        self.dataSource = dataSource
        
        super.init(section)
    }
    
    override func onInsert(_ pageInfo:PageInfo,loadingItentifier:ItemIdentifierType) {
        super.onInsert(pageInfo,loadingItentifier:loadingItentifier)
        var snapshot = self.dataSource.snapshot()
        snapshot.deleteItems([loadingItentifier])
        snapshot.appendItems(pageInfo.datas, toSection: self.section)
        if self.currentPage < self.totalPage {
            snapshot.appendItems( [self.createLoadingType(self.currentPage + 1)], toSection: self.section)
        }
        self.dataSource?.apply(snapshot)
    }
    open func insertLoadingType(_ page:Int = 1) {
        var snapshot = self.dataSource.snapshot()
        snapshot.appendItems([self.createLoadingType(page)], toSection: self.section)
        self.dataSource.apply(snapshot)
    }

    open override func provideLoadingCell(_ tableView:UITableView,indexPath:IndexPath,itemIdentifier:ItemIdentifierType) -> UITableViewCell {
        fatalError("need implement provideLoadingCell")
    }
    open override func provideDataCell(_ tableView:UITableView,indexPath:IndexPath,itemIdentifier:ItemIdentifierType) -> UITableViewCell {
        fatalError("need implement provideDataCell")
    }
    
}
