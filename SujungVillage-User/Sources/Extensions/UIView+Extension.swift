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
    
//    func roundTopCorners(radius: CGFloat = 30) {
//        self.clipsToBounds = true
//        self.layer.cornerRadius = radius
//        if #available(iOS 11.0, *) {
//            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        } else {
//            self.roundCorners(corners: [.topLeft, .topRight], radius: radius)
//        }
//    }
    
//    func roundTopLeftCorners(radius: CGFloat = 30) {
//        self.clipsToBounds = true
//        self.layer.cornerRadius = radius
//        if #available(iOS 11.0, *) {
//            self.layer.maskedCorners = [.layerMinXMinYCorner]
//        } else {
//            self.roundCorners(corners: .topLeft, radius: radius)
//        }
//    }
//
//    func roundTopRightCorners(radius: CGFloat = 30) {
//        self.clipsToBounds = true
//        self.layer.cornerRadius = radius
//        if #available(iOS 11.0, *) {
//            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        } else {
//            self.roundCorners(corners: .topRight, radius: radius)
//        }
//    }
//
//    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }

}
