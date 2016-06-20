//
//  TodayViewController.swift
//  Today
//
//  Created by Seyithan Teymur on 20/06/2016.
//  Copyright © 2016 Brokoli. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreMood
import Charts
import ViewModel

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var timeView: TimeScaleView!
    var dataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: ((NCUpdateResult) -> Void)) {
        self.timeView.setDay(dataController.today)
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
