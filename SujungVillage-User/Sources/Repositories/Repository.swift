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
    func doLogin(id: String, pwd: String, fcmToken: String, completion: @escaping (HTTPStatusCode, LoginResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/login",
            method: .post,
            parameters: ["id": id, "password": pwd, "fcm_token": fcmToken],
            encoding: JSONEncoding.default
        )
        .responseDecodable(of: LoginResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    // MARK: Get HomeInfo
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
    
    // MARK: Apply Exeat
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
    
    // MARK: Apply RollCall
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
    
    // MARK: Get LMPHistory
    func getLMPHistory(completion: @escaping (HTTPStatusCode, GetLMPHistoryResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/lmp/getLmpHistory",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getAcceptHeaders()
        )
        .responseDecodable(of: GetLMPHistoryResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    // MARK: Sign Up
    func signUp(signUpModel: SignUpModel, completion: @escaping (HTTPStatusCode, _ result: String)->Void) {
        AF.request(
            "\(baseUrl)/student/signup",
            method: .post,
            parameters: ["id": signUpModel.id, "password": signUpModel.password, "name": signUpModel.name, "dormitoryName": signUpModel.dormitoryName, "detailedAddress": signUpModel.detailedAddress, "phoneNumber": signUpModel.phoneNumber],
            encoding: JSONEncoding.default,
            headers: ["Content-Type": "application/json"]
        )
        .responseString { response in
            if let statusCode = response.response?.statusCode, let result = response.value {
                completion(HTTPStatusCode.init(rawValue: statusCode), result)
            }
        }
    }
}
