//
//  AppConfiguration.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 28/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit

public class AppConfiguration {
    public class var sharedConfiguration: AppConfiguration {
        struct Singleton {
            static let sharedAppConfiguration = AppConfiguration()
        }
        
        return Singleton.sharedAppConfiguration
    }
    
    public private(set) var isFirstLaunch: Bool {
        get {
            registerDefaults()
            
            return applicationUserDefaults.bool(forKey: DefaultsKeys.FirstLaunch)
        }
        set {
            applicationUserDefaults.set(newValue, forKey: DefaultsKeys.FirstLaunch)
        }
    }
    
    public func runHandlerOnFirstLaunch(_ firstLaunchHandler: (Void) -> Void) {
        if isFirstLaunch {
            isFirstLaunch = false
            
            firstLaunchHandler()
        }
    }
    
    struct DefaultsKeys {
        static let FirstLaunch = "AppConfiguration.Defaults.firstLaunchKey"
        
        static let NotificationHoursStart = "AppConfiguration.Defaults.NotificationHoursStart"
        static let NotificationHoursEnd = "AppConfiguration.Defaults.NotificationHoursEnd"
    }
    
    struct ApplicationGroups {
        static let primary = "group.tr.com.Brokoli.MoodTracker"
    }
    
    var applicationUserDefaults: Foundation.UserDefaults {
        return Foundation.UserDefaults(suiteName: ApplicationGroups.primary)!
    }
    
    private func registerDefaults() {
        #if os(iOS)
            let defaultOptions: [String: AnyObject] = [
                DefaultsKeys.FirstLaunch: true,
                
                DefaultsKeys.NotificationHoursStart: 8,
                DefaultsKeys.NotificationHoursEnd: 23
            ]
        #elseif os(watchOS)
            let defaultOptions: [String: AnyObject] = [
                Defaults.firstLaunchKey: true
            ]
        #endif
        
        applicationUserDefaults.register(defaultOptions)
    }
}
