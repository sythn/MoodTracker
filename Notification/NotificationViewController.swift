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

    @IBOutlet var timeScaleView: TimeScaleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.timeScaleView.day = DataController().today
    }

}
