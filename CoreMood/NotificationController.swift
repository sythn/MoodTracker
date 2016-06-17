//
//  NotificationController.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 28/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit
import CoreMood

public class NotificationController: NSObject, NotificationControllerType {
    public class func shared() -> NotificationController {
        struct Singleton {
            static let sharedNotificationController = NotificationController()
        }
        
        return Singleton.sharedNotificationController
    }
    
    private var notificationResetOperationQueue: OperationQueue
    
    override init() {
        notificationResetOperationQueue = OperationQueue()
        notificationResetOperationQueue.qualityOfService = .userInitiated
        notificationResetOperationQueue.maxConcurrentOperationCount = 1
    }
    
    public func checkAndAskUserForNotificationPermission() {
        if let settings = UIApplication.shared().currentUserNotificationSettings(),
            let category = settings.categories?.first {
            if settings.types.contains(.alert) && category.identifier == NotificationControllerKeys.Legacy.Notification.category {
                return
            }
        }
        
        registerNotificationSettings()
    }
    
    public func handleNotification(identifier: String?) {
        var mood: Mood?
        switch identifier {
        case NotificationControllerKeys.Legacy.Notification.Action.good?:
            mood = .good
            
        case NotificationControllerKeys.Legacy.Notification.Action.bad?:
            mood = .bad
            
        case NotificationControllerKeys.Legacy.Notification.Action.neutral?:
            mood = .neutral
            
        default:
            mood = nil
        }
        
        if let mood = mood {
            _ = DataController().addMood(mood)
        }
    }
    
    private func registerNotificationSettings() {
        let goodAction = UIMutableUserNotificationAction()
        goodAction.identifier = NotificationControllerKeys.Legacy.Notification.Action.good
        goodAction.activationMode = .background
        goodAction.title = "Good"
        
        let badAction = UIMutableUserNotificationAction()
        badAction.identifier = NotificationControllerKeys.Legacy.Notification.Action.bad
        badAction.activationMode = .background
        badAction.title = "Bad"
        
        let neutralAction = UIMutableUserNotificationAction()
        neutralAction.identifier = NotificationControllerKeys.Legacy.Notification.Action.neutral
        neutralAction.activationMode = .background
        neutralAction.title = "Neutral"
        
        let moodNotificationCategory = UIMutableUserNotificationCategory()
        moodNotificationCategory.identifier = NotificationControllerKeys.Legacy.Notification.category
        moodNotificationCategory.setActions([goodAction, badAction, neutralAction], for: .default)
        moodNotificationCategory.setActions([goodAction, badAction], for: .minimal)
        
        let settings = UIUserNotificationSettings(types: [.alert, .sound], categories: [moodNotificationCategory])
        
        UIApplication.shared().registerUserNotificationSettings(settings)
    }
    
    
    public func resetNotifications() {
        notificationResetOperationQueue.cancelAllOperations()
        notificationResetOperationQueue.addOperation { () -> Void in
            UIApplication.shared().cancelAllLocalNotifications()
            
            let notifications = self.notificationArray()
            
            for notification in notifications {
                UIApplication.shared().scheduleLocalNotification(notification)
            }
            
            print(UIApplication.shared().scheduledLocalNotifications)
        }
    }
    
    
    
    func notificationArray() -> [UILocalNotification] {
        guard let dayStart = Calendar.current().date(byAdding: .day, value: 0, to: Date(), options: []) else {
            return []
        }
        
        var notifications = [UILocalNotification]()

        let minutes = minutesForNotificationTime()
        
        for minute in minutes {
            for hour in CoreMood.UserDefaults.notificationHourStart...CoreMood.UserDefaults.notificationHourEnd {
                if let notificationTime = Calendar.current().date(bySettingHour: hour, minute: minute, second: 5, of: dayStart, options: []) {
                    notifications.append(localNotification(date: notificationTime))
                }
            }
        }
        
        return notifications
    }
    
    private func localNotification(date: Date, repeating: Bool = true) -> UILocalNotification {
        let notification = UILocalNotification()
        notification.alertBody = "How are you feeling?"
        notification.soundName = UILocalNotificationDefaultSoundName
        if repeating {
            notification.repeatInterval = .day
        }
        notification.category = NotificationControllerKeys.Legacy.Notification.category
        notification.fireDate = date
        return notification
    }
}



