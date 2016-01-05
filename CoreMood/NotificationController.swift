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
        
        registerNotificationSettings()
    }
    
    public func handleNotificationWithIdentifier(identifier: String?) {
        var mood: Mood?
        switch identifier {
        case Keys.MoodNotificationActionGood?:
            mood = .Good
            
        case Keys.MoodNotificationActionBad?:
            mood = .Bad
            
        case Keys.MoodNotificationActionNeutral?:
            mood = .Neutral
            
        default:
            mood = nil
        }
        
        if let mood = mood {
            DataController().addMood(mood)
        }
    }
    
    private func registerNotificationSettings() {
        let goodAction = UIMutableUserNotificationAction()
        goodAction.identifier = Keys.MoodNotificationActionGood
        goodAction.activationMode = .Background
        goodAction.title = "Good"
        
        let badAction = UIMutableUserNotificationAction()
        badAction.identifier = Keys.MoodNotificationActionBad
        badAction.activationMode = .Background
        badAction.title = "Bad"
        
        let neutralAction = UIMutableUserNotificationAction()
        neutralAction.identifier = Keys.MoodNotificationActionNeutral
        neutralAction.activationMode = .Background
        neutralAction.title = "Neutral"
        
        let moodNotificationCategory = UIMutableUserNotificationCategory()
        moodNotificationCategory.identifier = Keys.MoodNotificationCategory
        moodNotificationCategory.setActions([goodAction, badAction, neutralAction], forContext: .Default)
        moodNotificationCategory.setActions([goodAction, badAction], forContext: .Minimal)
        
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
            if let notificationTime = NSCalendar.currentCalendar().dateBySettingHour(hour, minute: 0, second: 5, ofDate: dayStart, options: []) {
                notifications.append(localNotificationWithDate(notificationTime))
            }
            
            if let halfHourNotificationTime = NSCalendar.currentCalendar().dateBySettingHour(hour, minute: 30, second: 5, ofDate: dayStart, options: []) {
                notifications.append(localNotificationWithDate(halfHourNotificationTime))
            }
        }
        
        return notifications
    }
    
    private func localNotificationWithDate(date: NSDate, repeating: Bool = true) -> UILocalNotification {
        let notification = UILocalNotification()
        notification.alertBody = "How are you feeling?"
        notification.soundName = UILocalNotificationDefaultSoundName
        if repeating {
            notification.repeatInterval = .Day
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

