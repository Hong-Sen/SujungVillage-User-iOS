//
//  MyQResponse.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/30.
//

import Foundation

struct MyQTitleResponse: Codable {
    let questionID: Int
    let title, redDate: String
    let answered: Bool

    enum CodingKeys: String, CodingKey {
        case questionID = "questionId"
        case title, redDate, answered
    }
}

struct MyQDetailResponse: Codable {
    let question: Question
    let answer: Answer?
}

struct Answer: Codable {
    let id: Int
    let writerName, content, regDate, modDate: String
}

struct Question: Codable {
    let id: Int
    let writerID, writerName, title, content: String
    let anonymous: Bool
    let reqDate, modDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case writerID = "writerId"
        case writerName, title, content, anonymous, reqDate, modDate
    }
}
