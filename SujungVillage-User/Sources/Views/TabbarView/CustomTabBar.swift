//
//  CustomTabBar.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/29.
//

import Foundation
import UIKit

class CustomTabBar : UITabBar {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -8.0)
        layer.shadowOpacity = 0.12
        layer.shadowRadius = 10.0
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 110
        return sizeThatFits
    }
}
