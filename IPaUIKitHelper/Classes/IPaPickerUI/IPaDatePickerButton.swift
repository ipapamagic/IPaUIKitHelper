//
//  IPaDatePickerButton.swift
//  IPaPickerUI
//
//  Created by IPa Chen on 2020/10/18.
//

import UIKit

@objc public protocol IPaDatePickerButtonDelegate {
    
    func datePickerButtonConfirm(_ button:IPaDatePickerButton)
    func datePickerButtonDidSelected(_ button:IPaDatePickerButton)
    @objc optional func toolBarConfirmText(for button:IPaDatePickerButton) -> String
    @objc optional func datePickerButtonDisplayTitle(_ button:IPaDatePickerButton) -> String
    @objc optional func datePickerButtonDisplayAttributedTitle(_ button:IPaDatePickerButton) -> NSAttributedString?
    @objc optional func datePickerButtonDisplayFormat(_ button:IPaDatePickerButton) -> String
    @objc optional func datePickerButtonDisplayStyle(_ button:IPaDatePickerButton) -> DateFormatter.Style
}
open class IPaDatePickerButton: UIButton,IPaDatePickerProtocol {
    public internal(set) lazy var pickerView:UIDatePicker = {
        return self.createDefaultPickerView(#selector(self.onSelectedDateUpdated(_:)))
    }()
    
    public lazy var toolBar:UIToolbar = {
        return self.createDefaultToolBar()
    }()
    public var selectedDate:Date {
        get {
            return self.pickerView.date
        }
        set {
            self.pickerView.date = newValue
            self.updateUI()
        }
    }
    var toolBarConfirmText: String {
        return self.delegate.toolBarConfirmText?(for: self) ?? "Done"
    }
    var onPickerConfirm: Selector {
        return #selector(self.onPickerDone(_:))
    }
    
    @IBOutlet open var delegate:IPaDatePickerButtonDelegate!
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
    
    @objc func onPickerDone(_ sender:Any) {
        //MARK:insert your onDone code
        resignFirstResponder()
        self.delegate.datePickerButtonConfirm(self)
    }
    func updateUI() {
        if let title = self.delegate.datePickerButtonDisplayTitle?(self) {
            self.setTitle(title, for: .normal)
            return
        }
        let dateFormatter = DateFormatter()
        let date = self.selectedDate
        if let format = self.delegate.datePickerButtonDisplayFormat?(self) {
            dateFormatter.dateFormat = format
        }
        else if let style = self.delegate.datePickerButtonDisplayStyle?(self) {
            dateFormatter.dateStyle = style
        }
        let title = dateFormatter.string(from: date)
        self.setTitle(title, for: .normal)
    }
    @objc func onSelectedDateUpdated(_ sender:Any) {
        self.delegate.datePickerButtonDidSelected(self)
        self.updateUI()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
