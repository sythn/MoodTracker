//
//  NotificationControllerType.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 17/06/16.
//  Copyright © 2016 Brokoli. All rights reserved.
//

import Foundation

public protocol NotificationControllerType: class, NSObjectProtocol {
    func checkAndAskUserForNotificationPermission()
    func handleNotification(identifier: String?)
    
    func resetNotifications()
    
    func minutesForNotificationTime() -> [Int]
}

extension NotificationControllerType {
    public func minutesForNotificationTime() -> [Int] {
        var lowerMinute = 0
        #if DEBUG
            let currentMinute = Calendar.current().component(.minute
                , from: Date())
            lowerMinute = currentMinute + 1
            if lowerMinute >= 30 {
                lowerMinute -= 30
            }
            return [lowerMinute, lowerMinute + 1, lowerMinute + 5, lowerMinute + 30];
        #endif
        
        return [lowerMinute, lowerMinute+30]
    }
}

struct NotificationControllerKeys {
    struct Legacy {
        struct Notification {
            static let category = "NotificationController.MoodNotificationCategory"
            
            struct Action {
                static let good = "NotificationController.MoodNotificationActionGood"
                static let bad = "NotificationController.NotificationActionBad"
                static let neutral = "NotificationController.NotificationActionNeutral"
            }
        }
    }
    
    struct Notification {
        static let category = "NotificationController.MoodNotificationCategory.User"
        
        struct Action {
            static let good = "NotificationController.MoodNotificationActionGood.User"
            static let bad = "NotificationController.NotificationActionBad.User"
            static let neutral = "NotificationController.NotificationActionNeutral.User"
        }
    }
}
