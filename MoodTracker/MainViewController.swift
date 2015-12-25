//
//  ViewController.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 01/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit
import CoreMood
import Charts

class MainViewController: UIViewController {
    
    @IBOutlet var timeChart: TimeScaleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

