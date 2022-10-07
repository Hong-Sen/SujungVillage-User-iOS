//
//  RollCallResponse.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/07.
//

import Foundation

struct RollCallResponse: Codable {
    let id: Int
    let userID, image, location, rollcallDateTime: String
    let state: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case image, location, rollcallDateTime, state
    }
}
