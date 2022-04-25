//
//  IPaDatePickerTableViewCell.swift
//  IPaPickerUI
//
//  Created by IPa Chen on 2020/10/12.
//

import UIKit
@objc public protocol IPaDatePickerTableViewCellDelegate {
    
    func datePickerTableViewCellConfirm(_ cell:IPaDatePickerTableViewCell)
    func datePickerTableViewCellDidSelected(_ cell:IPaDatePickerTableViewCell)
    @objc optional func toolBarConfirmText(for cell:IPaDatePickerTableViewCell) -> String
}
open class IPaDatePickerTableViewCell: UITableViewCell,IPaDatePickerProtocol {
    public private(set) lazy var pickerView:UIDatePicker = {
        return self.createDefaultPickerView(#selector(self.onSelectedDateUpdated(_:)))
    }()
    open var selectedDuration:TimeInterval {
        get {
            return self.pickerView.countDownDuration
        }
        set {
            self.pickerView.countDownDuration = newValue
            self.updateUI()
        }
    }
    open var selectedDate:Date {
        get {
            return self.pickerView.date
        }
        set {
            self.pickerView.date = newValue
            self.updateUI()
        }
    }
    public private(set) lazy var toolBar:UIToolbar = {
        return self.createDefaultToolBar()
    }()
    var toolBarConfirmText: String {
        return self.delegate.toolBarConfirmText?(for: self) ?? "Done"
    }
    var onPickerConfirm: Selector {
        return #selector(self.onPickerDone(_:))
    }
    
    @IBOutlet open var delegate:IPaDatePickerTableViewCellDelegate!
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
    open override var canBecomeFirstResponder: Bool {
        return true
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.becomeFirstResponder()
        }
        // Configure the view for the selected state
    }
    @objc func onPickerDone(_ sender:Any) {
        //MARK:insert your onDone code
        resignFirstResponder()
        self.delegate.datePickerTableViewCellConfirm(self)
    }
    open func updateUI() {
        
    }
    @objc func onSelectedDateUpdated(_ sender:Any) {
        self.delegate.datePickerTableViewCellDidSelected(self)
        self.updateUI()
        
    }
}
