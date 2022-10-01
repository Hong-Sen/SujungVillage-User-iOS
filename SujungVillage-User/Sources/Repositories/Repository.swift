//
//  Repository.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/01.
//

import Foundation
import Alamofire

class Repository {
    private init() {}
    static let shared = Repository()
    private let baseUrl = API.shared.base_url
}

extension Repository {
    func loginWithGoogle(token: String, completion: @escaping (HTTPStatusCode, LoginResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/login",
            method: .post,
            parameters: ["access_token": token, "fcm_token": ""],
            encoding: JSONEncoding.default
        )
        .responseDecodable(of: LoginResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
}

