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
    var dataController = DataController()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func goodButtonTapped() {
        self.dataController.addMood(.Good)
        updateChart()
    }
    
    @IBAction func badButtonTapped() {
        self.dataController.addMood(.Bad)
        updateChart()
    }
    
    func updateChart() {
        self.timeChart.setDay(dataController.today)
    }
}

