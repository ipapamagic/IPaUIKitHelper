//
//  IPaDataPager.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/4/5.
//

import UIKit

public protocol IPaDataPagerHasLoadType {

    var isLoadingType:Bool { get }
    
}

open class IPaDataPager<SectionIdentifierType,ItemIdentifierType,ContainerType,CellType>: NSObject where SectionIdentifierType:Hashable,ItemIdentifierType:Hashable,ItemIdentifierType:IPaDataPagerHasLoadType {
    var totalPage:Int = 1
    var currentPage:Int = 0
    var loadingPage:Int = 0
    public private(set) var section:SectionIdentifierType
    public struct PageInfo {
        var totalPage:Int
        var currentPage:Int
        var datas:[ItemIdentifierType]
        public init(currentPage:Int,totalPage:Int,datas:[ItemIdentifierType]) {
            self.currentPage = currentPage
            self.totalPage = totalPage
            self.datas = datas
        }
    }
    init(_ section:SectionIdentifierType)  {
        self.section = section
        super.init()
        
    }
    public func provideCell(_ view:ContainerType,indexPath:IndexPath,itemIdentifier:ItemIdentifierType) -> CellType {
        if itemIdentifier.isLoadingType {
            let nextPage = self.currentPage + 1
            if self.loadingPage == 0 {
                self.loadData(nextPage) { pageInfo in
                    self.onInsert(pageInfo,loadingItentifier: itemIdentifier)
                }
            }
            return self.provideLoadingCell(view, indexPath: indexPath, itemIdentifier: itemIdentifier)
        }
        else {
            return self.provideDataCell(view, indexPath: indexPath, itemIdentifier: itemIdentifier)
        }
    }
    func provideLoadingCell(_ view:ContainerType,indexPath:IndexPath,itemIdentifier:ItemIdentifierType) -> CellType {
        fatalError("need implement provideLoadingCell()")
    }
    func provideDataCell(_ view:ContainerType,indexPath:IndexPath,itemIdentifier:ItemIdentifierType) -> CellType {
        fatalError("need implement provideDataCell()")
    }
    func onInsert(_ pageInfo:PageInfo,loadingItentifier:ItemIdentifierType) {
        self.totalPage = pageInfo.totalPage
        self.currentPage = pageInfo.currentPage
        self.loadingPage = 0
        
    }
        
    open func createLoadingType(_ page:Int) -> ItemIdentifierType {
        fatalError("need implement createLoadingType")
    }
    open func loadData(_ page:Int,complete:@escaping (PageInfo)->()) {
        fatalError("need implement loadData(_:complete:)")
    }
}
