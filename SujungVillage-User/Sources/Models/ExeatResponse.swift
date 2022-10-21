//
//  ApplyExeatModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/07.
//

import Foundation

struct ApplyExeatModel {
    var destination, reason, emergencyPhoneNumber, dateToStart, dateToEnd: String
}

struct GetAppliedExeatResponse: Codable {
    let id: Int
    let userID, destination, reason, emergencyPhoneNumber, dateToUse: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case destination, reason, emergencyPhoneNumber, dateToUse
    }
}
