//
//  UserLoginManager.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/01.
//

import GoogleSignIn
import Alamofire

class UserLoginManager {
    private let googleClinetId: String = "365548458558-oaf0ge0qs5aif2i0doonmfngjit98t1m.apps.googleusercontent.com"
    
    private lazy var configuration: GIDConfiguration = {
        return GIDConfiguration(clientID: googleClinetId)
    }()
    
    static let shared = UserLoginManager()
    //    private override init() { }
    
    func setUser(
        jwtToken: String? = nil
    ) {
        let defaults = UserDefaults.standard
        // 기존 유저정보가 존재하지 않으면
        if defaults.object(forKey: "jwtToken") == nil {
            if let jwtToken = jwtToken {
                defaults.set(jwtToken, forKey: "jwtToken")
            }
        }
    }
    
    func doLoginWithGoogle() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { user, error in
            if let error = error { return }
            
            guard let user = user, let idToken = user.authentication.idToken else { return }
            
            Repository.shared.loginWithGoogle(token: idToken) { status, loginResponse in
                switch status {
                case .ok:
                    if let jwtToken = loginResponse?.jwtToken {
                        self.setUser(jwtToken: jwtToken)
                    }
                default:
                    print("error: \(status)")
                    break
                }
            }
        }
    }
    
    func doLogoutWithGoogle() {
        UserDefaults.standard.removeObject(forKey: "jwtToken")
        GIDSignIn.sharedInstance.signOut()
    }
}
