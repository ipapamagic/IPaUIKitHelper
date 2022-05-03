//
//  IPaPicker.swift
//  IPaPickerUI
//
//  Created by IPa Chen on 2020/10/12.
//

import UIKit

protocol _IPaPickerProtocol:UIView,UIPickerViewDelegate,UIPickerViewDataSource {
    var onPickerConfirm:Selector {get}
    func updateUI(_ titles:[String]?)
}

public protocol IPaPickerProtocol {
    var firstSelection:Int {get nonmutating set}
    var selections:[Int] {get nonmutating set}
    var pickerView:UIPickerView { get}
    var toolBarConfirmText:String {get}
}
protocol IPaPickerProtocols:IPaPickerProtocol,_IPaPickerProtocol {
    
}
extension IPaPickerProtocols {
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
    public var firstSelection:Int {
        get {
            return self.selections.first ?? 0
        }
        set {
            self.selections = [newValue]
        }
    }
    public var selections:[Int] {
        get {
            var selections = [Int]()
            for component in 0 ..< self.pickerView.numberOfComponents {
                selections.append(self.pickerView.selectedRow(inComponent: component))
            }
            return selections
        }
        set {
            var titles = [String]()
            for (idx,row) in newValue.enumerated() {
                self.pickerView.selectRow(row, inComponent: idx, animated: false)
                titles.append(self.pickerView?(self.pickerView, titleForRow: row, forComponent: idx) ?? "")
            }
            
            self.updateUI(titles)
        }
    }
}
