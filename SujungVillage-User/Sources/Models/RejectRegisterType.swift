//
//  RejectRegisterType.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2023/01/17.
//

import Foundation

enum RejectRegisterType {
    case overlapId
    case differentPwd
    case noName
    case noPhoneNumber
    case unselectDormitory
    case unwrittenRoom
    case notAgreeTerms
}
