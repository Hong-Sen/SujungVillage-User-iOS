//
//  Repository.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/01.
//

import Foundation
import Alamofire

class Repository: NSObject {
//    private override init() {}
    static let shared = Repository()
    private let baseUrl = API.shared.base_url
}

// MARK: Auth
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

// MARK: HomeInfo
extension Repository {
    func getHomeInfo(year: Int, month: Int, completion: @escaping (HTTPStatusCode, HomeResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/home/getInfo?year=\(year)&month=\(month)",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getHeaders()
        )
        .responseDecodable(of: HomeResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
}
