//
//  IPaPicker.swift
//  IPaPickerUI
//
//  Created by IPa Chen on 2020/10/12.
//

import UIKit

protocol IPaPickerProtocol:UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    var pickerView:UIPickerView { get set}
    var toolBar:UIToolbar {get set }
    var toolBarConfirmText:String {get}
    var onPickerConfirm:Selector {get}
    var selection:[Int] {get set}
    func updateUI(_ titles:[String]?)
    func createDefaultPickerView() -> UIPickerView
    func createDefaultToolBar() -> UIToolbar
}
extension IPaPickerProtocol {
    func createDefaultPickerView() -> UIPickerView {
        let pickerView = UIPickerView(frame:.zero)
        pickerView.delegate = self
        pickerView.dataSource = self
//        pickerView.showsSelectionIndicator = true
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
    func getSelection() -> [Int] {
        var selection = [Int]()
        for component in 0 ..< self.pickerView.numberOfComponents {
            selection.append(self.pickerView.selectedRow(inComponent: component))
        }
        return selection
    }
    func setSelection(_ selection:[Int]) {
        var titles = [String]()
        for (idx,row) in selection.enumerated() {
            self.pickerView.selectRow(row, inComponent: idx, animated: false)
            titles.append(self.pickerView?(pickerView, titleForRow: row, forComponent: idx) ?? "")
        }
        
        self.updateUI(titles)
    
    }
    
}
