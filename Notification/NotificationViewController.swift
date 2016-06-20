//
//  NotificationViewController.swift
//  Notification
//
//  Created by Seyithan Teymur on 16/06/16.
//  Copyright © 2016 Brokoli. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import CoreMood
import Charts
import ViewModel

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    typealias Keys = NotificationControllerKeys.Notification

    @IBOutlet var timeScaleView: TimeScaleView!
    
    var dataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.timeScaleView.setDay(self.dataController.today)
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: (UNNotificationContentExtensionResponseOption) -> Void) {
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
            _ = self.dataController.addMood(mood)
        }
        
        self.timeScaleView.setDay(self.dataController.today)
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        let time = DispatchTime.now() + DispatchTimeInterval.seconds(1)
        DispatchQueue.main.after(when: time) { 
            completion(.dismiss)
        }
    }

}
