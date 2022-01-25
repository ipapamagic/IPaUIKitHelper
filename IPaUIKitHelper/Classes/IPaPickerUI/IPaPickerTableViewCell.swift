//
//  IPaPickerTableViewCell.swift
//  Pods
//
//  Created by IPa Chen on 2018/1/22.
//  Copyright 2018年 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc public protocol IPaPickerTableViewCellDelegate {
    func pickerTableViewCell(_ cell:IPaPickerTableViewCell,numberOfRowsIn component:Int) -> Int
    @objc optional func pickerTableViewCell(_ cell:IPaPickerTableViewCell,titleFor row:Int,for component:Int) -> String
    
    @objc optional func pickerTableViewCell(_ cell:IPaPickerTableViewCell,attributedTitleFor row:Int,for component:Int) -> NSAttributedString
    
    func pickerTableViewCell(_ cell:IPaPickerTableViewCell,didSelect row:Int,for component:Int)
    func pickerTableViewCellConfirm(_ cell:IPaPickerTableViewCell)
    @objc optional func pickerTableViewCell(_ cell:IPaPickerTableViewCell,rowWidthFor component:Int) -> CGFloat
    @objc optional func pickerTableViewCell(_ cell:IPaPickerTableViewCell,rowHeightFor component:Int) -> CGFloat
    @objc optional func numberOfComponents(for cell:IPaPickerTableViewCell) -> Int
    @objc optional func toolBarConfirmText(for cell:IPaPickerTableViewCell) -> String
}

open class IPaPickerTableViewCell :UITableViewCell,IPaPickerProtocol {
    var toolBarConfirmText: String {
        return self.delegate.toolBarConfirmText?(for: self) ?? "Done"
    }
    var onPickerConfirm: Selector {
        return #selector(self.onPickerDone(_:))
    }
    open var selection: [Int] {
        get {
            return self.getSelection()
        }
        set {
            self.setSelection(newValue)
        }
    }
    lazy var pickerView:UIPickerView = {
        return self.createDefaultPickerView()
    }()

    lazy var toolBar:UIToolbar = {
        return self.createDefaultToolBar()
    }()
    @IBOutlet open var delegate:IPaPickerTableViewCellDelegate! {
        didSet {
            self.updateUI(nil)
        }
    }
    
    override open var inputView:UIView! {
        get {
            return pickerView as UIView
            
        }
    }
    override open var inputAccessoryView:UIView! {
        get {
            return toolBar as UIView
        }
    }
    override open func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    override open func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            becomeFirstResponder()
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func onPickerDone(_ sender:Any) {
        //MARK:insert your onDone code
        resignFirstResponder()
        self.delegate.pickerTableViewCellConfirm(self)
    }
    func updateUI(_ titles: [String]?) {
        
    }
    
}


extension IPaPickerTableViewCell :UIPickerViewDelegate,UIPickerViewDataSource
{
    //MARK: UIPickerViewDataSource
    // returns the number of 'columns' to display.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.delegate.numberOfComponents?(for: self) ?? 1
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.delegate.pickerTableViewCell(self, numberOfRowsIn: component)
    }
    //MARK: UIPickerViewDelegate
    // returns width of column and height of row for each component.
    
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    {
        return self.delegate.pickerTableViewCell?(self, rowWidthFor: component) ?? 100
    }
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return self.delegate.pickerTableViewCell?(self, rowHeightFor: component) ?? 44
    }
    
    // these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
    // for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
    // If you return back a different object, the old one will be released. the view will be centered in the row rect
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.delegate.pickerTableViewCell?(self, titleFor: row, for: component)
    }
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return self.delegate.pickerTableViewCell?(self, attributedTitleFor: row, for: component)
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.delegate.pickerTableViewCell(self, didSelect: row,for:component)
    }
}
