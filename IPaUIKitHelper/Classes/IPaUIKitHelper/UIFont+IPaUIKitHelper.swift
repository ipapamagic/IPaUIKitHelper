//
//  UIFont+IPaUIKitHelper.swift
//  IPaUIKitHelper
//
//  Created by IPa Chen on 2021/8/26.


import UIKit

public extension UIFont.TextStyle {
    /// Returns a non-scaling font for the specified text style
    /// at system default settings
    var baseFont: UIFont {
        return UIFont.systemFont(ofSize: defaultPointSize, weight: defaultWeight)
    }
    /// Returns the a non-scaling font with the point size of the current text
    /// style and the specified weight
    /// Returns the default weight for the current text style
    /// at system default settings
    var defaultWeight: UIFont.Weight {
        switch self {
        case .headline:
            return .semibold
        default:
            return .regular
        }
    }
    
    /// Returns the default point size for the current text style
    /// at system default settings
    var defaultPointSize: CGFloat {
        switch self {
        case .largeTitle:
            return 34
        case .title1:
            return 28
        case .title2:
            return 22
        case .title3:
            return 20
        case .headline:
            return 17
        case .body:
            return 17
        case .callout:
            return 16
        case .subheadline:
            return 15
        case .footnote:
            return 13
        case .caption1:
            return 12
        case .caption2:
            return 11
        default:
            return 17
        }
    }
}
extension UIFont {
    public var boldItalic:UIFont? {
        return self.withTraits(.traitBold,.traitItalic)
    }
    @objc public class func systemFont(of style:UIFont.TextStyle,weight:UIFont.Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let font = UIFont.systemFont(ofSize: style.defaultPointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
    @objc public class func italicSystemFont(ofSize size:CGFloat,weight:UIFont.Weight) -> UIFont? {
        switch weight {
        case .ultraLight, .light, .thin, .regular:
            let font = UIFont.systemFont(ofSize: size)
            return font.withTraits(.traitItalic)
        case .medium, .semibold, .bold, .heavy, .black:
            let font = UIFont.systemFont(ofSize: size)
            return font.withTraits(.traitBold, .traitItalic)
        default:
            return UIFont.italicSystemFont(ofSize: size)
        }
    }
    public func withTraits(_ traits:UIFontDescriptor.SymbolicTraits...) -> UIFont? {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) else {
            return nil
        }
        return UIFont(descriptor: descriptor, size: self.pointSize)
    }
    
}

