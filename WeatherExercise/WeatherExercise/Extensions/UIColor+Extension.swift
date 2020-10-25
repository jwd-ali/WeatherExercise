//
//  UIColor+Extension.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 22/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static let universalColor1: UIColor = appColor(named: "universalcolor1")!
    
    static let universalColor2: UIColor = appColor(named: "universalcolor2")!
    
    static let universalColor3: UIColor = appColor(named: "universalcolor3")!
    
    static let universalColor4: UIColor = appColor(named: "universalcolor4")!
    
    static let universalColor5: UIColor = appColor(named: "universalcolor5")!
    
    static let universalColor6: UIColor = appColor(named: "universalcolor6")!
    
    
    private static func appColor(named: String) -> UIColor?{
        #if TARGET_INTERFACE_BUILDER
        return UIColor.systemGray
        #else
        return UIColor(named: named)
        #endif
    }
}

