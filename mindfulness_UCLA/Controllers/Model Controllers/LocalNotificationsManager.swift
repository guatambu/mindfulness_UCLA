//
//  LocalNotificationsManager.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 11/2/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation
import UserNotifications


struct MyNotification {
    var id: String
    var title: String
    var body: String
    var soundFilePath: String
}

class LocalNotificationsManager {
    
    var notifications = [MyNotification]()
    
    
    // function to check the current contents of the notifications array
    func listScheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            
            for notification in notifications {
                print(notification)
            }
        }
    }
    
    // function to ask for user permission for notifications
    private func requestAuthorization(duration InSeconds: Int) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            
            if granted == true && error == nil {
                self.scheduleNotifications(duration: InSeconds)
            }
        }
    }
    
    // function to check status of user permission when scheduling a notification
    func schedule(duration inSeconds: Int) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(duration: inSeconds)
            case .authorized, .provisional:
                self.scheduleNotifications(duration: inSeconds)
            default:
                break // Do nothing
            }
        }
    }
    
    // function to schedule a notificaiton
    private func scheduleNotifications(duration inSeconds: Int) {
        
        for notification in notifications
        {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: notification.soundFilePath))
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(inSeconds), repeats: false)
            
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                
                guard error == nil else { return }
                
                print("Notification scheduled! --- ID = \(notification.id)")
            }
        }
    }
}
