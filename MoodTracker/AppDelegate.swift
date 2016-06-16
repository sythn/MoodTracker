//
//  AppDelegate.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 01/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit
import CoreMood

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        AppConfiguration.sharedConfiguration.runHandlerOnFirstLaunch {
        }
        
        NotificationController.sharedController.checkAndAskUserForNotificationPermission()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        NotificationController.sharedController.resetNotificationsWithDayCount(1)
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: () -> Void) {
        NotificationController.sharedController.handleNotificationWithIdentifier(identifier)
        completionHandler()
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        NotificationController.sharedController.handleNotificationWithIdentifier(identifier)
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

