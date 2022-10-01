//
//  API.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/01.
//

import Foundation

class API {
    private init() {}
    
    static let shared: API = API()
    
    let base_url = "http://15.165.188.210:8080/api"
}
