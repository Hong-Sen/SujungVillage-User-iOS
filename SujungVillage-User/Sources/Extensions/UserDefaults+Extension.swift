//
//  UserDefaults+Extension.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/07.
//

import Foundation

extension UserDefaults {
    @objc dynamic var autoLogin: Bool { // 자동로그인
        get { self.bool(forKey: "autoLogin") ?? false }
        set { self.setValue(newValue, forKey: "autoLogin") }
    }
    
    @objc dynamic var needLogin: Bool { // 로그인 창 유무
        get { self.bool(forKey: "needLogin") ?? true }
        set { self.setValue(newValue, forKey: "needLogin") }
    }
    
    @objc dynamic var pushNotification: Bool { // 푸쉬 알림
        get { self.bool(forKey: "pushNotification") ?? false }
        set { self.setValue(newValue, forKey: "pushNotification") }
    }
}
