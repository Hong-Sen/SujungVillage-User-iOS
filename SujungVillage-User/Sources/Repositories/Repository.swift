//
//  Repository.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/01.
//

import Foundation
import Alamofire

class Repository: NSObject {
    static let shared = Repository()
    private let baseUrl = API.shared.base_url
}

extension Repository {
    // MARK: Auth
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
    
    // MARK: HomeInfo
    func getHomeInfo(year: Int, month: Int, completion: @escaping (HTTPStatusCode, HomeResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/home/getInfo?year=\(year)&month=\(month)",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getAcceptHeaders()
        )
        .responseDecodable(of: HomeResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    // MARK: Exeat
    func applyExeat(applyModel: ApplyExeatModel, completion: @escaping (HTTPStatusCode)->Void) {
        AF.request(
        "\(baseUrl)/student/exeat/applyExeat",
        method: .post,
        parameters: ["destination": applyModel.destination, "reason": applyModel.reason, "emergencyPhoneNumber": applyModel.emergencyPhoneNumber, "dateToStart": applyModel.dateToStart, "dateToEnd": applyModel.dateToEnd],
        encoding: JSONEncoding.default,
        headers: API.shared.getContentTypeHeaders()
        )
        .responseDecodable(of: RollCallResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode))
            }
        }
    }
    
    // MARK: RollCall
    func applyRollCall(image: Array<UInt8>, location: String, completion: @escaping (HTTPStatusCode, RollCallResponse?)->Void) {
        AF.request(
        "\(baseUrl)/student/rollcall/applyRollcall",
        method: .post,
        parameters: ["image":image, "location": location],
        encoding: JSONEncoding.default,
        headers: API.shared.getContentTypeHeaders()
        )
        .responseDecodable(of: RollCallResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
}
