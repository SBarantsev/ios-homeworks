//
//  AppDelegate.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit
import FirebaseCore
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        
        let notificationService = LocalNotificationsService()
        notificationService.registerForLatestUpdatesIfPossible()
        
        let title = "Новое уведомление"
        let body = "Посмотрите последние обновления"
        var data = DateComponents()
        data.hour = 19
        data.minute = 00
        
        notificationService.addNotification(title: title, body: body, date: data)
        
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

    
//    func applicationDidFinishLaunching(_ application: UIApplication) {
//        print("step 0")
//        let notificationService = LocalNotificationsService()
//        notificationService.registerForLatestUpdatesIfPossible()
//        print("step 1")
//        let title = "Новое уведомление"
//        let body = "Посмотрите последние обновления"
//        var data = DateComponents()
//        data.hour = 0
//        data.minute = 37
//
//        notificationService.addNotification(title: title, body: body, date: data)
//        print("step 3")
//    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner, .badge, .sound]
    }
}
