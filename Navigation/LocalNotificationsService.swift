//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Sergey on 18.09.2024.
//

import Foundation
import UserNotifications

class LocalNotificationsService {
    
    func registerForLatestUpdatesIfPossible() {
        Task {
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        }
    }
    
    func checkPermission() async -> Bool {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        return settings.authorizationStatus == .authorized
    }
    
    func addNotification(id: String? = nil, title: String, body: String, date: DateComponents) {
        removeNotification()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: id == nil ? UUID().uuidString : id!, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        print("step 4")
    }
    
    func removeNotification() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
