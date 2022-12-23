//
//  UserLoginManager.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/01.
//

import Alamofire

class UserLoginManager {
    static let shared = UserLoginManager()
    
    func setUser(
        id: String? = nil,
        jwtToken: String? = nil,
        refreshToken: String? = nil
    ) {
        let defaults = UserDefaults.standard
        if let id = id,
        let jwtToken = jwtToken,
            let refreshToken = refreshToken {
                defaults.set(id, forKey: "id")
                defaults.set(jwtToken, forKey: "jwtToken")
                defaults.set(refreshToken, forKey: "refreshToken")
            }
    }
    
    func doLoginInVC(id: String, pwd: String, fcmToken: String, completion: @escaping(Bool)->Void)  {
        Repository.shared.doLogin(id: id, pwd: pwd, fcmToken: fcmToken) { status, loginResponse in
            switch status {
            case .ok:
                if let jwtToken = loginResponse?.jwtToken ,
                   let refreshToken = loginResponse?.refreshToken {
                    self.setUser(id: id, jwtToken: jwtToken, refreshToken: refreshToken)
                }
                completion(true)
            default:
                completion(false)
                print("do login error: \(status)")
                break
            }
        }
    }
    
    func doLogout() {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "jwtToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        UserDefaults.standard.autoLogin = false
    }
    
    func isValidToken(token: String, completion: @escaping (Bool)->Void) {
        Repository.shared.checkTokenValid(token: token) { status, result in
            switch status {
            case .ok:
                if result == "true" { completion(true) }
                else { completion(false) }
            default:
                print("check valid token error: \(status)")
            }
        }
    }
    
    func doRefresh(completion: @escaping (Bool)->Void) {
        let defaults = UserDefaults.standard
        if let id = defaults.string(forKey: "id"),
           let refreshToken = defaults.string(forKey: "refreshToken") {
            Repository.shared.doRefresh(id: id, refreshToken: refreshToken) { status, response in
                switch status {
                case .ok:
                    if let jwtToken = response?.jwtToken {
                        defaults.set(jwtToken, forKey: "jwtToken")
                        completion(true)
                    }
                default:
                    print("do refresh error: \(status)")
                    completion(false)
                }
            }
        }
    }
}
