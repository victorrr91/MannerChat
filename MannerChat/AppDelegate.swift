//
//  AppDelegate.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/12.
//

import UIKit
import SendbirdChatSDK
import TAKUUID

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let appId = Bundle.main.SEND_BIRD_APP_ID
        let initParams = InitParams(
            applicationId: appId
        )

        SendbirdChat.initialize(params: initParams, completionHandler:  { error in
            print(error)
        })

        /// User.id가 저장 될 UUID 키체인에 접근 - 사용은 사용할 곳에서 직접 키체인에 접근
        TAKUUIDStorage.sharedInstance().migrate()

        return true
    }

    // MARK: UISceneSession Lifecycle

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


}

