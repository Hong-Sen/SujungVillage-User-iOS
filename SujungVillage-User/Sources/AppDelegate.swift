//
//  AppDelegate.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let defaults = UserDefaults.standard
        if defaults.autoLogin {
            if let jwtToken = defaults.string(forKey: "jwtToken") {
                UserLoginManager.shared.isValidToken(token: jwtToken) { isValid in
                    if isValid { return }
                    if let refreshToken = defaults.string(forKey: "refreshToken") {
                        UserLoginManager.shared.isValidToken(token: refreshToken) { isValid in
                            if isValid {
                                UserLoginManager.shared.doRefresh()
                            }
                            else {
                                defaults.autoLogin = false
                                defaults.needLogin = true
                            }
                        }
                    }
                }
            }
        }
        else {
            defaults.needLogin = true
        }
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Handle other custom URL types.
        
        // If not handled by this app, return false.
        return false
    }
    
}

