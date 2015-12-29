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
    
    private var notificationResetOperationQueue: NSOperationQueue
    
    init() {
        notificationResetOperationQueue = NSOperationQueue()
        notificationResetOperationQueue.qualityOfService = .UserInitiated
        notificationResetOperationQueue.maxConcurrentOperationCount = 1
    }
    
    public func checkAndAskUserForNotificationPermission() {
        if let settings = UIApplication.sharedApplication().currentUserNotificationSettings(),
            let category = settings.categories?.first {
                if settings.types.contains(.Alert) && category.identifier == Keys.MoodNotificationCategory {
                    return
                }
        }
        
        let goodAction = UIMutableUserNotificationAction()
        goodAction.identifier = Keys.MoodNotificationActionGood
        goodAction.title = "Good"
        
        let badAction = UIMutableUserNotificationAction()
        goodAction.identifier = Keys.MoodNotificationActionBad
        goodAction.title = "Bad"
        
        let neutralAction = UIMutableUserNotificationAction()
        goodAction.identifier = Keys.MoodNotificationActionNeutral
        goodAction.title = "Neutral"
        
        let moodNotificationCategory = UIMutableUserNotificationCategory()
        moodNotificationCategory.identifier = Keys.MoodNotificationCategory
        moodNotificationCategory.setActions([goodAction, badAction], forContext: .Minimal)
        moodNotificationCategory.setActions([goodAction, badAction, neutralAction], forContext: .Default)
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Sound], categories: [moodNotificationCategory])
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    public func resetNotificationsWithDayCount(dayCount: Int) {
        notificationResetOperationQueue.cancelAllOperations()
        notificationResetOperationQueue.addOperationWithBlock { () -> Void in
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
            for day in 0..<1 {
                let notifications = self.notificationArrayForDayOffset(day)
                
                for notification in notifications {
                    UIApplication.sharedApplication().scheduleLocalNotification(notification)
                }
            }
            
            print(UIApplication.sharedApplication().scheduledLocalNotifications)
        }
    }
    
    func notificationArrayForDayOffset(dayOffset: Int) -> [UILocalNotification] {
        guard let dayStart = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 0, toDate: NSDate(), options: []) else {
            return []
        }
        
        var notifications = [UILocalNotification]()
        for hour in UserDefaults.notificationHourStart...UserDefaults.notificationHourEnd {
            if let notificationTime = NSCalendar.currentCalendar().dateBySettingHour(hour, minute: 7, second: 0, ofDate: dayStart, options: []) {
                
                let notification = UILocalNotification()
                notification.alertBody = "How are you feeling?"
                notification.soundName = UILocalNotificationDefaultSoundName
                notification.repeatInterval = .Day
                notification.category = Keys.MoodNotificationCategory
                notification.fireDate = notificationTime
                
                notifications.append(notification)
            }
        }
        
        return notifications
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

