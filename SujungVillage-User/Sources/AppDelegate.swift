//
//  AppDelegate.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/27.
//

import UIKit
import FirebaseCore
import UserNotifications
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // push notification
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            if granted {
                print("알림 등록이 완료되었습니다.")
            }
        }
        application.registerForRemoteNotifications()
        
        // 자동로그인
        let defaults = UserDefaults.standard
        if defaults.autoLogin {
            if let jwtToken = defaults.string(forKey: "jwtToken") {
                UserLoginManager.shared.isValidToken(token: jwtToken) { isValid in
                    if isValid {
                        return
                    }
                    if let refreshToken = defaults.string(forKey: "refreshToken") {
                        UserLoginManager.shared.isValidToken(token: refreshToken) { isValid in
                            if isValid {
                                UserLoginManager.shared.doRefresh { finish in
                                    if finish {
                                        return
                                    }
                                    else {
                                        defaults.needLogin = true
                                    }
                                }
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
            print("#6")
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

extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler:@escaping(UNNotificationPresentationOptions)-> Void) {
        
        let userInfo = notification.request.content
        let time = Date().toStringIncludeTime()
        saveNotification(title: userInfo.title, content: userInfo.body, time: time)
        completionHandler([.alert, .sound]) // 앱 foreground 상태일때 알림 받기
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) { // 앱 background일 때 알림 받기
        
        let userInfo = response.notification.request.content
        let time = Date().toStringIncludeTime()
        saveNotification(title: userInfo.title, content: userInfo.body, time: time)
      
        NotificationCenter.default.post(name: Notification.Name("showCommunityTab"), object: nil)
        
        let application = UIApplication.shared
        //앱이 켜져있는 상태에서 푸쉬 알림을 눌렀을 때
        if application.applicationState == .active {
            print("푸쉬알림 탭(앱 켜져있음)")
        }
        
        //앱이 꺼져있는 상태에서 푸쉬 알림을 눌렀을 때
        if application.applicationState == .inactive {
            print("푸쉬알림 탭(앱 꺼져있음)")
        }
    }
    
    func saveNotification(title: String, content: String, time: String) {
        if title == "새로운 댓글이 작성되었습니다." {
            var notificationList: [NotificationResponse] = UserDefaultsManager.shared.load(type: .community)
            notificationList.append(NotificationResponse(type: title, content: content, regDate: time))
            UserDefaultsManager.shared.save(type: .community, notificationList)
            print("Appdelegate: \(UserDefaultsManager.shared.load(type: .community))")
        }
        else {
            var notificationList: [NotificationResponse] = UserDefaultsManager.shared.load(type: .app)
            notificationList.append(NotificationResponse(type: title, content: content, regDate: time))
            UserDefaultsManager.shared.save(type: .app, notificationList)
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcm = fcmToken {
            UserDefaults.standard.set(fcm, forKey: "fcmToken")
            print("FCM Token: \(fcm)")
        }
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
