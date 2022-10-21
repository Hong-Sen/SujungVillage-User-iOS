//
//  LoginResponse.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/01.
//

import Foundation

struct LoginResponse: Codable {
    var jwtToken: String?
//    var refreshToken: String?
}

struct SignUpModel: Codable {
    var id, password, name, dormitoryName, detailedAddress, phoneNumber: String
}
