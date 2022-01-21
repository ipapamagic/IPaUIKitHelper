//
//  IPaDatePickerProtocol.swift
//  IPaPickerUI
//
//  Created by IPa Chen on 2020/10/12.
//

import UIKit

protocol IPaDatePickerProtocol:UIView {
    var pickerView:UIDatePicker { get set}
    var toolBar:UIToolbar {get set }
    var toolBarConfirmText:String {get}
    var onPickerConfirm:Selector {get}
    var selectedDate:Date {get set}
    func updateUI()
    func createDefaultPickerView(_ action:Selector) -> UIDatePicker
    func createDefaultToolBar() -> UIToolbar
    func onSelectedDateUpdated(_ sender:Any)
}
extension IPaDatePickerProtocol {
    
    func createDefaultPickerView(_ action:Selector) -> UIDatePicker {
        let pickerView = UIDatePicker(frame:.zero)
        if #available(iOS 13.4, *) {
            pickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        pickerView.addTarget(self, action: action, for: .valueChanged)
            
        return pickerView
    }
    func createDefaultToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = .black
        toolBar.isTranslucent = true
        toolBar.autoresizingMask = .flexibleHeight
        toolBar.sizeToFit()
        var frame = toolBar.frame
        frame.size.height = 44
        toolBar.frame = frame;
        let doneBtn = UIBarButtonItem(title: self.toolBarConfirmText, style: .done, target: self, action: onPickerConfirm)
        let flexibleSpaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let array = [flexibleSpaceLeft,doneBtn]
        toolBar.items = array
        return toolBar
    }
    
}
