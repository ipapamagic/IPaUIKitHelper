//
//  IPaHasHTMLContent.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/7/26.
//

import UIKit

import WebKit
protocol IPaHasHTMLContent {
    func replaceCSSPtToPx(with string:String) -> String
}

extension IPaHasHTMLContent  {
    
    func replaceCSSPtToPx(with string:String) -> String {
        guard let regex = try? NSRegularExpression(pattern: "(\\d+)pt", options:  NSRegularExpression.Options()) else {
            return string
        }
        let newString = regex.stringByReplacingMatches(in: string, options: [], range: NSRange(string.startIndex..., in:string), withTemplate: "$1px")
        
        
        return newString
    }
}
