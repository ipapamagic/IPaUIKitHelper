//
//  UITextField+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2022/5/4.
//

import UIKit

extension UITextField {
    public func checkResultDouble(changeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = self.text else {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        let finalText = (text as NSString).replacingCharacters(in: range, with: string)
        
        if finalText.count == 0 {
            return true
        }
        
        let scanner = Scanner(string: finalText)
        
        guard let _ = scanner.scanDouble(),scanner.isAtEnd else {
            return false
        }
        
        return true
    }
    public func checkResultInt(changeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = self.text else {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        let finalText = (text as NSString).replacingCharacters(in: range, with: string)
        
        if finalText.count == 0 {
            return true
        }
        let scanner = Scanner(string: finalText)
        guard let _ = scanner.scanInt(),scanner.isAtEnd else {
            return false
        }
        return true
    }
}
