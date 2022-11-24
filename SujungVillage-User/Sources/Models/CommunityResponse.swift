//
//  CommunityResponse.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/11/24.
//

import Foundation

struct CommunityPostResponse: Codable {
    let id: Int
        let title, content, writerID, regDate: String
        let numOfComments: Int

        enum CodingKeys: String, CodingKey {
            case id, title, content
            case writerID = "writerId"
            case regDate, numOfComments
        }
    }
