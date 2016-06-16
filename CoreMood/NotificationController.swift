//
//  NotificationController.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 28/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit
import CoreMood

public class NotificationController {
    public class var sharedController: NotificationController {
        struct Singleton {
            static let sharedNotificationController = NotificationController()
        }
        
        return Singleton.sharedNotificationController
    }
    
    private var notificationResetOperationQueue: OperationQueue
    
    init() {
        notificationResetOperationQueue = OperationQueue()
        notificationResetOperationQueue.qualityOfService = .userInitiated
        notificationResetOperationQueue.maxConcurrentOperationCount = 1
    }
    
    public func checkAndAskUserForNotificationPermission() {
        if let settings = UIApplication.shared().currentUserNotificationSettings(),
            let category = settings.categories?.first {
                if settings.types.contains(.alert) && category.identifier == Keys.MoodNotificationCategory {
                    return
                }
        }
        
        registerNotificationSettings()
    }
    
    public func handleNotificationWithIdentifier(_ identifier: String?) {
        var mood: Mood?
        switch identifier {
        case Keys.MoodNotificationActionGood?:
            mood = .good
            
        case Keys.MoodNotificationActionBad?:
            mood = .bad
            
        case Keys.MoodNotificationActionNeutral?:
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
        goodAction.identifier = Keys.MoodNotificationActionGood
        goodAction.activationMode = .background
        goodAction.title = "Good"
        
        let badAction = UIMutableUserNotificationAction()
        badAction.identifier = Keys.MoodNotificationActionBad
        badAction.activationMode = .background
        badAction.title = "Bad"
        
        let neutralAction = UIMutableUserNotificationAction()
        neutralAction.identifier = Keys.MoodNotificationActionNeutral
        neutralAction.activationMode = .background
        neutralAction.title = "Neutral"
        
        let moodNotificationCategory = UIMutableUserNotificationCategory()
        moodNotificationCategory.identifier = Keys.MoodNotificationCategory
        moodNotificationCategory.setActions([goodAction, badAction, neutralAction], for: .default)
        moodNotificationCategory.setActions([goodAction, badAction], for: .minimal)
        
        let settings = UIUserNotificationSettings(types: [.alert, .sound], categories: [moodNotificationCategory])
        
        UIApplication.shared().registerUserNotificationSettings(settings)
    }
    
    
    public func resetNotificationsWithDayCount(_ dayCount: Int) {
        notificationResetOperationQueue.cancelAllOperations()
        notificationResetOperationQueue.addOperation { () -> Void in
            UIApplication.shared().cancelAllLocalNotifications()
            
            for day in 0..<1 {
                let notifications = self.notificationArrayForDayOffset(day)
                
                for notification in notifications {
                    UIApplication.shared().scheduleLocalNotification(notification)
                }
            }
            
            print(UIApplication.shared().scheduledLocalNotifications)
        }
    }
    
    func notificationArrayForDayOffset(_ dayOffset: Int) -> [UILocalNotification] {
        guard let dayStart = Calendar.current().date(byAdding: .day, value: 0, to: Date(), options: []) else {
            return []
        }
        
        var notifications = [UILocalNotification]()
        for hour in CoreMood.UserDefaults.notificationHourStart...CoreMood.UserDefaults.notificationHourEnd {
            if let notificationTime = Calendar.current().date(bySettingHour: hour, minute: 0, second: 5, of: dayStart, options: []) {
                notifications.append(localNotificationWithDate(notificationTime))
            }
            
            if let halfHourNotificationTime = Calendar.current().date(bySettingHour: hour, minute: 30, second: 5, of: dayStart, options: []) {
                notifications.append(localNotificationWithDate(halfHourNotificationTime))
            }
        }
        
        return notifications
    }
    
    private func localNotificationWithDate(_ date: Date, repeating: Bool = true) -> UILocalNotification {
        let notification = UILocalNotification()
        notification.alertBody = "How are you feeling?"
        notification.soundName = UILocalNotificationDefaultSoundName
        if repeating {
            notification.repeatInterval = .day
        }
        notification.category = Keys.MoodNotificationCategory
        notification.fireDate = date
        return notification
    }
}

private extension NotificationController {
    private struct Keys {
        static let MoodNotificationCategory = "NotificationController.MoodNotificationCategory"

        static let MoodNotificationActionGood = "NotificationController.MoodNotificationActionGood"
        static let MoodNotificationActionBad = "NotificationController.NotificationActionBad"
        static let MoodNotificationActionNeutral = "NotificationController.NotificationActionNeutral"
    }
}

