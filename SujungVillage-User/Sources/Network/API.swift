//
//  API.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/01.
//

import Foundation
import Alamofire

class API {
    private init() {}
    
    static let shared: API = API()
    
    let base_url = "http://15.165.188.210:8080/api"
    
    func getAcceptHeaders() -> HTTPHeaders? {
        var headers: HTTPHeaders = []
        if let jwtToken = UserDefaults.standard.string(forKey: "jwtToken") {
            headers = [ "Accept": "application/json",
                        "jwt_token": jwtToken]
        }
        return headers
    }
    
    func getContentTypeHeaders() -> HTTPHeaders? {
        var headers: HTTPHeaders = []
        if let jwtToken = UserDefaults.standard.string(forKey: "jwtToken") {
            headers = [ "Content-Type": "application/json",
                        "jwt_token": jwtToken ]
        }
        return headers
    }
}
