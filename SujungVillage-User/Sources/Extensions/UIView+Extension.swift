//
//  UIView+Extension.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/09.
//

import UIKit

extension UIView {
    func roundCorners(corners: [UIRectCorner], radius: CGFloat = 30) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        switch corners {
        case [.topLeft]:
            self.layer.maskedCorners = .layerMinXMinYCorner
        case [.topRight]:
            self.layer.maskedCorners = .layerMaxXMinYCorner
        case [.topLeft, .topRight]:
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case [.bottomLeft]:
            self.layer.maskedCorners = .layerMinXMaxYCorner
        case [.bottomRight]:
            self.layer.maskedCorners = .layerMaxXMaxYCorner
        case [.bottomLeft, .bottomRight]:
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            return
        }
    }
}
