//
//  IPaTabbarController.swift
//  IPaStoryboardSegues
//
//  Created by IPa Chen on 2020/9/11.
//

import UIKit

public protocol IPaTabbarItem:UIView
{
    var isSelected:Bool {get set}
    func addTargetForTap(_ target: Any?, action: Selector)
}
public protocol IPaTabbarItemContainer:UIView {
    var tabbarItems:[IPaTabbarItem] {get}
}
extension UIStackView:IPaTabbarItemContainer {
    public var tabbarItems:[IPaTabbarItem] {
        return self.arrangedSubviews as? [IPaTabbarItem] ?? [IPaTabbarItem]()
    }
}
extension UIButton:IPaTabbarItem
{
    public func addTargetForTap(_ target: Any?, action: Selector) {
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}
open class IPaTabbarController: IPaContainerViewController {
    open var tabIdList:[String]!
    open var initialTabId:String?
    open var tabbarItemsContainer:IPaTabbarItemContainer!
    @IBOutlet open var itemsContainerView:UIView! {
        get {
            return tabbarItemsContainer!
        }
        set {
            tabbarItemsContainer = (newValue as! IPaTabbarItemContainer)
        }
    }
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.tabIdList = self.initialTabIdList()
        let tabItems = self.tabbarItemsContainer.tabbarItems
    
        for (index , tabItem) in tabItems.enumerated() {
            let identifier = self.tabIdList[index]
            self.configureTabbarItem(tabItem, identifier: identifier)
        }
    
        
        // Do any additional setup after loading the view.
    }
    open func initialTabIdList() -> [String]{
        return []
    }
    open func configureTabbarItem(_ item:IPaTabbarItem,identifier:String) {
        item.addTargetForTap(self, action: #selector(self.onTabItem(_:)))
    }
    @objc open func onTabItem(_ sender:Any?) {
        let itemList = self.tabbarItemsContainer.tabbarItems
        guard let item = sender as? IPaTabbarItem,let index = itemList.firstIndex(where: { itemTab in
            return Bool(itemTab === item)
        }) else {
            return
        }
        let identifier = self.tabIdList[index]
        self.gotoViewController(identifier)
    }
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.currentViewController == nil {
            let tabId = (initialTabId ?? tabIdList.first!)
            self.gotoViewController(tabId)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    open override func gotoViewController(_ identifier: String?, destination: UIViewController) {
        super.gotoViewController(identifier, destination: destination)
        
        self.reloadTabbar()
    }
    open func reloadTabbar() {
        guard let currentViewController = self.currentViewController, let identifier = self.getIdentifier(of: currentViewController) , let index = self.tabIdList.firstIndex(of: identifier) else {
            return
        }
        let buttons = self.tabbarItemsContainer.tabbarItems
        for (idx,button) in buttons.enumerated() {
            button.isSelected = (idx == index)
        }
        
    }
}
