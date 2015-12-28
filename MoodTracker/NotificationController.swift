//
//  NotificationController.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 28/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit

class NotificationController: NSObject {
    var notificationStartHour: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(UserDefaultsKeys.NotificationStartHour)
        }
        set {
            NSUserDefaults.standardUserDefaults().setInteger(notificationStartHour, forKey: UserDefaultsKeys.NotificationStartHour)
        }
    }
    
    var notificationEndHour: Int {
        get {
            return NSUserDefaults.standardUserDefaults().integerForKey(UserDefaultsKeys.NotificationEndHour)
        }
        
        set {
            NSUserDefaults.standardUserDefaults().setInteger(notificationEndHour, forKey: UserDefaultsKeys.NotificationEndHour)
        }
    }
}
