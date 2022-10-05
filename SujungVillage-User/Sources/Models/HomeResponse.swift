//
//  HomeResponse.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/02.
//

import Foundation

struct HomeResponse: Codable {
    let residentInfo: ResidentInfo
    let rollcallDays, appliedRollcallDays, appliedExeatDays: [Day]
}

struct Day: Codable {
    let id, day: Int
}

struct ResidentInfo: Codable {
    let name, dormitoryName, detailedAddress: String
    let plusLMP, minusLMP: Int
}
