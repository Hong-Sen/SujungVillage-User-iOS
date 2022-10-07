//
//  UIColor+Extension.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/29.
//

import Foundation
import UIKit

extension UIColor {
    @nonobjc class var primary:UIColor {
        return UIColor(hexString: "FFA114")
    }
    
    @nonobjc class var plight:UIColor {
        return UIColor(hexString: "FFD250")
    }
    
    @nonobjc class var pdark: UIColor {
        return UIColor(hexString: "BE6E00")
    }
    
    @nonobjc class var text_black: UIColor {
        return UIColor(hexString: "434343")
    }
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0xFF00) >> 8) / 255.0, blue: CGFloat(rgb & 0xFF) / 255.0, alpha: alpha)
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
