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
               layer.masksToBounds = true
               layer.cornerRadius = 20
               layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
         }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 110
        return sizeThatFits
    }
}
