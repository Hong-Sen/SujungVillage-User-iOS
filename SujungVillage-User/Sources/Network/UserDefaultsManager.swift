//
//  UserDefaultsManager.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/23.
//

import Foundation

enum NotificationType {
    case app
    case community
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    func save(type: NotificationType, _ notifications: [NotificationResponse]) {
        let data = notifications.map { try? JSONEncoder().encode($0) }
        switch type {
        case .app:
            UserDefaults.standard.set(data, forKey: "appNotificationList")
        case .community:
            UserDefaults.standard.set(data, forKey: "communityNotificationList")
        }
    }

    func load(type: NotificationType) -> [NotificationResponse] {
        switch type {
        case .app:
            guard let encodedData = UserDefaults.standard.array(forKey: "appNotificationList") as? [Data] else {
                return []
            }
            return encodedData.map { try! JSONDecoder().decode(NotificationResponse.self, from: $0) }
        case .community:
            guard let encodedData = UserDefaults.standard.array(forKey: "communityNotificationList") as? [Data] else {
                return []
            }
            return encodedData.map { try! JSONDecoder().decode(NotificationResponse.self, from: $0) }
        }
    }
}
