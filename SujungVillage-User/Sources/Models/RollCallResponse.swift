//
//  RollCallResponse.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/07.
//

import Foundation
import UIKit

struct CreateRollCallResponse: Codable {
    let id: Int
    let image: [Int8]
    let userID, location, rollcallDateTime: String
    let state: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case image, location, rollcallDateTime, state
    }
}

struct GetRollCallInfoResponse: Codable {
    let id: Int
    let image: [Int8]
    let userID: String
    let location: String
    let rollcallDateTime: String
    let state: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case image, location, rollcallDateTime, state
    }
}
