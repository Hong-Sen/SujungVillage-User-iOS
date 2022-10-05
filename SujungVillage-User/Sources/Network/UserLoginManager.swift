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
    
    func setUser(
        jwtToken: String? = nil
    ) {
        let defaults = UserDefaults.standard
        if let jwtToken = jwtToken {
            defaults.set(jwtToken, forKey: "jwtToken")
        }
        defaults.isLogined = true
    }
    
    func doLoginWithGoogle(vc : UIViewController) {
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: vc) { user, error in
            if let error = error { return }
            
            guard let user = user, let idToken = user.authentication.idToken else { return }
            
            Repository.shared.loginWithGoogle(token: idToken) { status, loginResponse in
                switch status {
                case .ok:
                    if let jwtToken = loginResponse?.jwtToken {
                        print("jwtToken: \(jwtToken)")
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
        UserDefaults.standard.isLogined = false
        GIDSignIn.sharedInstance.signOut()
    }
}
