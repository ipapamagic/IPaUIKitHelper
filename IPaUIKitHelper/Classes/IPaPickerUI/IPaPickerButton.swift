//
//  IPaPickerButton.swift
//  Pods
//
//  Created by IPa Chen on 2018/1/22.
//  Copyright 2018年 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc public protocol IPaPickerButtonDelegate {
    func pickerButton(_ button:IPaPickerButton,numberOfRowsIn component:Int) -> Int
    
    @objc func pickerButton(_ button:IPaPickerButton,titleFor row:Int,for component:Int) -> String
    @objc optional func pickerButton(_ button:IPaPickerButton,attributedTitleFor row:Int,for component:Int) -> NSAttributedString?
    func pickerButton(_ button:IPaPickerButton,didSelect row:Int,for component:Int)
    func pickerButtonConfirm(_ button:IPaPickerButton)
    @objc optional func pickerButton(_ button:IPaPickerButton, rowWidthFor component:Int) -> CGFloat
    @objc optional func pickerButton(_ button:IPaPickerButton, rowHeightFor component:Int) -> CGFloat
    @objc optional func numberOfComponents(for button:IPaPickerButton) -> Int
    @objc(toolBarConfirmTextForPickerButton:)
    optional func toolBarConfirmText(for button:IPaPickerButton) -> String
    //choose one func for title contribution
    
    @objc optional func pickerButtonDisplayTitle(_ button:IPaPickerButton) -> String
    @objc optional func pickerButton(_ button:IPaPickerButton,displayTitleFor titles:[String]) -> String
    @objc optional func pickerButtonUpdateUI(_ button:IPaPickerButton)
}

open class IPaPickerButton :UIButton,IPaPickerProtocol {
    var toolBarConfirmText: String {
        return self.delegate.toolBarConfirmText?(for: self) ?? "Done"
    }
    
    var onPickerConfirm: Selector {
        return #selector(self.onPickerDone(_:))
    }

    public internal(set) lazy var pickerView:UIPickerView = {
        return self.createDefaultPickerView()
    }()
    public internal(set) lazy var toolBar:UIToolbar = {
        return self.createDefaultToolBar()
    }()
    open var selection: [Int] {
        get {
            return self.getSelection()
        }
        set {
            self.setSelection(newValue)
        }
    }
    @IBOutlet open var delegate:IPaPickerButtonDelegate!
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self,
                  action:#selector(self.onTouch(_:)),
                  for:.touchUpInside)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTarget(self,
                  action:#selector(self.onTouch(_:)),
                  for:.touchUpInside)
    }
    
    @objc func onTouch(_ sender:Any) {
        becomeFirstResponder()
    }

    @objc func onPickerDone(_ sender:Any) {
        //MARK:insert your onDone code
        resignFirstResponder()
        self.updateUI()
        self.delegate.pickerButtonConfirm(self)
    }
    func updateUI(_ titles:[String]? = nil) {
        if let delegateUpdateUI = self.delegate.pickerButtonUpdateUI {
            delegateUpdateUI(self)
            return
        }
        if let title = self.delegate.pickerButtonDisplayTitle?(self) {
            self.setTitle(title, for: .normal)
        }
        var titleList = [String]()
        if let titles = titles {
            titleList = titles
        }
        else {
            
            for component in 0 ..< self.numberOfComponents(in: pickerView) {
                let row = self.pickerView.selectedRow(inComponent: component)
                titleList.append(self.pickerView(pickerView, titleForRow: row, forComponent: component) ?? "")
            }
            
            
        }
        if let title = self.delegate.pickerButton?(self, displayTitleFor: titleList) {
            self.setTitle(title, for: .normal)
        }
        else {
            let title = titleList.joined(separator: " ")
            self.setTitle(title, for: .normal)
        }
    }
}
extension IPaPickerButton
{
    //MARK: UIPickerViewDataSource
    // returns the number of 'columns' to display.
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.delegate.numberOfComponents?(for: self) ?? 1
    }
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.delegate.pickerButton(self, numberOfRowsIn: component)
    }
    //MARK: UIPickerViewDelegate
    // returns width of column and height of row for each component.

    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    {
        return self.delegate.pickerButton?(self, rowWidthFor: component) ?? 100
    }
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return self.delegate.pickerButton?(self, rowHeightFor: component) ?? 44
    }
    
    // these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
    // for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
    // If you return back a different object, the old one will be released. the view will be centered in the row rect
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.delegate.pickerButton(self, titleFor: row, for: component)
    }
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return self.delegate.pickerButton?(self, attributedTitleFor: row, for: component)
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.delegate.pickerButton(self, didSelect: row, for: component)
        self.updateUI()
    }
}
