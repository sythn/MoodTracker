//
//  AppDelegate.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 01/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit
import CoreMood
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var notificationController: NotificationControllerType?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        if #available(iOS 10.0, *) {
            self.notificationController = UserNotificationController.shared()
        } else {
            self.notificationController = NotificationController.shared()
        }
        
        AppConfiguration.sharedConfiguration.runHandlerOnFirstLaunch {
        }
        
        self.notificationController?.checkAndAskUserForNotificationPermission()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        self.notificationController?.resetNotifications()
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: () -> Void) {
        self.notificationController?.handleNotification(identifier: identifier)
        completionHandler()
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        self.notificationController?.handleNotification(identifier: identifier)
        completionHandler()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }


}

