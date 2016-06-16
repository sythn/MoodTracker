//
//  UserDefaults.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 28/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit

public struct UserDefaults {
    public static var notificationHourStart: Int {
        get {
            return AppConfiguration.sharedConfiguration.applicationUserDefaults.integer(forKey: AppConfiguration.DefaultsKeys.NotificationHoursStart)
        }
        
        set(start){
            AppConfiguration.sharedConfiguration.applicationUserDefaults.set(start, forKey: AppConfiguration.DefaultsKeys.NotificationHoursStart)
        }
    }
    
    public static var notificationHourEnd: Int {
        get {
            return AppConfiguration.sharedConfiguration.applicationUserDefaults.integer(forKey: AppConfiguration.DefaultsKeys.NotificationHoursEnd)
        }
        
        set(end) {
            AppConfiguration.sharedConfiguration.applicationUserDefaults.set(end, forKey: AppConfiguration.DefaultsKeys.NotificationHoursEnd)
        }
    }
}
