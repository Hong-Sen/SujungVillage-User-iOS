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
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        self.addShadow(location: .top, color: .black, opacity: 0.12, radius: 10)
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 110
        return sizeThatFits
    }
}
