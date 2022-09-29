//
//  UIFont+Extension.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/29.
//

import Foundation
import UIKit

public extension UIFont {
    
    enum Family: String {
        case Bold, ExtraBold, ExtraLight, Heavy, Light, Medium, Regular, SemiBold, Thin
    }
    
    static func suit(size: CGFloat = 10, family: Family = .Regular) -> UIFont {
        return UIFont(name: "SUIT-\(family)", size: size) ?? .systemFont(ofSize: size)
    }
    
}
