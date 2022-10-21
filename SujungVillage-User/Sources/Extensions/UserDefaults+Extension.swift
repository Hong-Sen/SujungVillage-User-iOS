//
//  UserDefaults+Extension.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/07.
//

import Foundation

extension UserDefaults {
    @objc dynamic var isLogedIn: Bool {
        get { self.bool(forKey: "isLogedIn") ?? false }
        set { self.setValue(newValue, forKey: "isLogedIn") }
    }
}
