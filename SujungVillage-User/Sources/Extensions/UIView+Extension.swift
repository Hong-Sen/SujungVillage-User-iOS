//
//  UIView+Extension.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/09.
//

import UIKit

extension UIView {
    func roundCorners(corners: [UIRectCorner], radius: CGFloat) {
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
        case [.allCorners]:
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            return
        }
    }
    
    enum Direction {
        case bottom
        case top
        case left
        case right
    }
    
    func addShadow(location: Direction, color: UIColor = .black, opacity: Float, radius: CGFloat) {
        switch location {
        case .bottom:
            setShadow(offset: CGSize(width: 0, height: 5), color: color, opacity: opacity, radius: radius)
        case .top:
            setShadow(offset: CGSize(width: 0, height: -5), color: color, opacity: opacity, radius: radius)
        case .left:
            setShadow(offset: CGSize(width: -5, height: 0), color: color, opacity: opacity, radius: radius)
        case .right:
            setShadow(offset: CGSize(width: 5, height: 0), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func setShadow(offset: CGSize, color: UIColor, opacity: Float, radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}
