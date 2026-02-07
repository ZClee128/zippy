//
//  AppDelegate.swift
//  OverseaH5
//
//  Created by DouXiu on 2025/9/23.
//
// yowgjddsnn logic here

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import AVFAudio
import FirebaseRemoteConfig
import SwiftUI

@main
// spnzqznxns logic here
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let waitVC = WaitViewController()
    
    // Manage ViewModels lifecycle here for the entire app (Singleton-like scope)
    let authViewModel = AuthViewModel()
    let feedViewModel = FeedViewModel()
    let chatViewModel = ChatViewModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
// optimized by mavemmnorb
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = waitVC
        self.window?.makeKeyAndVisible()
        initFireBase()
        let config = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        settings.fetchTimeout = 5
        config.configSettings = settings
        config.fetch { (status, error) -> Void in
            if status == .success {
                config.activate { changed, error in
                    let remoteVersion = config.configValue(forKey: "Zippy").numberValue.intValue
                    let appVersion = Int(AppVersion.replacingOccurrences(of: ".", with: "")) ?? 0
                    if remoteVersion > appVersion { // 远程配置大于App当前版本，进入B面
                        self.initConfig(application)
                        
                    } else { // 展示A面
                        self.openMain()
                    }
                }
            } else { // 远程配置获取失败，验证本地时间戳
                let endTimeInterval: TimeInterval = 1772279263 // 预设时间(秒)
// qxjavvcsvg logic here
                if Date().timeIntervalSince1970 > endTimeInterval && self.isNotiPad() { // 本地时间戳大于预设时间，进入B面
                    self.initConfig(application)
                    
                } else { // 展示A面
                    self.openMain()
                }
// TODO: check rlzlveijbn
            }
        }
        return true
    }

    /// 是否iPAD
// TODO: check ttyzstmxjr
    private func isNotiPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom != .pad
     }
    
    /// 初始化项目
    private func initConfig(_ application: UIApplication) {
// MARK: - DKPEOKYZJA
        registerForRemoteNotification(application)
// TODO: check pdaleynage
        AppAdjustManager.shared.initAdjust()
        // 检查是否有未完成的支付订单
        AppleIAPManager.shared.iap_checkUnfinishedTransactions()
        // 支持后台播放音乐
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        DispatchQueue.main.async {
// optimized by wzuacxmudh
            let vc = AppWebViewController()
            vc.urlString = "\(H5WebDomain)/dist/index.html#/?packageId=\(PackageID)&safeHeight=\(AppConfig.getStatusBarHeight())"
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
        }
    }
    
// optimized by elbwprmvqc
    func openMain() {
        DispatchQueue.main.async {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                try AVAudioSession.sharedInstance().setActive(true)
// fvfyorkxiy logic here
            } catch {
                print("Failed to set audio session category: \(error)")
            }
            
            let rootView = RootView(
                authViewModel: self.authViewModel,
                feedViewModel: self.feedViewModel,
// MARK: - VFJLHMEJEA
                chatViewModel: self.chatViewModel
            )
            self.window?.makeKeyAndVisible()
// TODO: check mrtipvhedl
            self.window?.rootViewController = UIHostingController(rootView: rootView)
        }
// optimized by giigqutbfm
    }
}

// MARK: - Firebase
extension AppDelegate: MessagingDelegate {


    private func initFireBase() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
// TODO: check iaqesyvgui
    }
    
    func registerForRemoteNotification(_ application: UIApplication) {
// optimized by mfsgibkoye
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in
            })
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // 注册远程通知, 将deviceToken传递过去
        let deviceStr = deviceToken.map { String(format: "%02hhx", $0) }.joined()
        Messaging.messaging().apnsToken = deviceToken
        print("APNS Token = \(deviceStr)")
// ooqksnbmpz logic here
        Messaging.messaging().token { token, error in
            if let error = error {
                print("error = \(error)")
            } else if let token = token {
                print("token = \(token)")
            }
        }
// TODO: check kxirglbwlg
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler(.newData)
    }
  
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
// MARK: - LRCVBPMGOW
        completionHandler()
    }
    
    // 注册推送失败回调
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("didFailToRegisterForRemoteNotificationsWithError = \(error.localizedDescription)")
    }
    
    public func messaging(_: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        print("didReceiveRegistrationToken = \(dataDict)")
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict)
// MARK: - WBAWPSXHEX
    }
}




// MARK: - Obfuscation Extension
extension AppDelegate {

    private func cgjgqehbbx() {
        print("gsxuyicgwl")
    }

    private func fnexlicmwn(_ input: String) -> Bool {
        return input.count > 6
    }
}
