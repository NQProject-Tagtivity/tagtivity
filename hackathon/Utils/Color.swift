//
//  Color.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 20/11/2020.
//

import Foundation
import UIKit

extension UIColor {
    
    struct app {
        
        static let yellow = UIColor(netHex: 0xFFBB00)
        static let darkBlue = UIColor(netHex: 0x0A1451)
        static let lightGray = UIColor(netHex: 0xE7E7E7)
        static let darkGray = UIColor(netHex: 0x9E9E9E)
    }
}

typealias MainFont = Font.Nunito

/// Example: `Font.AvenirNext.demiBold.with(size: 16)`
enum Font {
        
    enum Nunito: String {
        case semiBold = "SemiBold"
        case regular = "Regular"
        case italic = "Italic"
        case extraLight = "ExtraLight"
        case extraLightItalic = "ExtraLightItalic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case semiBoldItalic = "SemiBoldItalic"
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case extraBold = "ExtraBold"
        case black = "Black"
        
        func with(size: CGFloat) -> UIFont? {
            return UIFont(name: "Nunito-\(rawValue)", size: size)
        }
    }
}
