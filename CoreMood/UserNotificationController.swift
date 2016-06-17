//
//  UserNotificationController.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 17/06/16.
//  Copyright © 2016 Brokoli. All rights reserved.
//

import Foundation
import CoreMood
import UserNotifications

@available(iOS 10.0, *)
public class UserNotificationController: NSObject, NotificationControllerType, UNUserNotificationCenterDelegate {
    
    typealias Keys = NotificationControllerKeys.Notification
    
    public class func shared() -> UserNotificationController {
        struct Singleton {
            static let sharedNotificationController = UserNotificationController()
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
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == UNAuthorizationStatus.authorized &&
                settings.alertSetting == .enabled {
                
                UNUserNotificationCenter.current().getNotificationCategories(completionHandler: { (categories) in
                    if (categories.contains { $0.identifier == Keys.category }) {
                        return
                    }
                })
                
            }
            
            self.registerForUserNotifications()
        }
    }
    
    private func registerForUserNotifications() {
        UNUserNotificationCenter.current().requestAuthorization([.alert, .sound]) { (granted, error) in
            self.registerUserNotificationCategories()
        }
    }
    
    private func registerUserNotificationCategories() {
        let goodAction = UNNotificationAction(identifier: Keys.Action.good, title: "Good", options: [])
        let badAction = UNNotificationAction(identifier: Keys.Action.bad, title: "Bad", options: [])
        let neutralAction = UNNotificationAction(identifier: Keys.Action.neutral, title: "Neutral", options: [])
        
        
        let category = UNNotificationCategory(identifier: Keys.category, actions: [goodAction, badAction, neutralAction], minimalActions: [goodAction, badAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    public func resetNotifications() {
        notificationResetOperationQueue.cancelAllOperations()
        notificationResetOperationQueue.addOperation {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
            let minutes = self.minutesForNotificationTime()
            for minute in minutes {
                
                for hour in CoreMood.UserDefaults.notificationHourStart...CoreMood.UserDefaults.notificationHourEnd {
                    
                    let triggerComponents = DateComponents(hour: hour, minute: minute, second: 4)
                    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: true)
                    
                    let content = UNMutableNotificationContent()
                    content.body = "How are you feeling?"
                    content.categoryIdentifier = NotificationControllerKeys.Notification.category
                    
                    let notificationRequest = UNNotificationRequest(identifier: triggerComponents.description, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(notificationRequest) { (error) in
                        if let error = error {
                            print("Error adding notification: \(error)")
                        }
                    }
                    
                }
                UNUserNotificationCenter.current().getPendingNotificationRequests() { requests in print(requests) }
            }
        }
        
    }
    
    public func handleNotification(identifier: String?) {
        print("handleNotification(identifier:) should not have been called on UserNotificationController.")
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
        var mood: Mood?
        
        switch response.actionIdentifier {
        case Keys.Action.good:
            mood = .good
            
        case Keys.Action.bad:
            mood = .bad
            
        case Keys.Action.neutral:
            mood = .neutral
            
        default:
            mood = nil
        }
        
        if let mood = mood {
            _ = DataController().addMood(mood)
        }
        
        completionHandler()
    }
    
    
}
