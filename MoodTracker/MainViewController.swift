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
    @IBOutlet var descriptionLabel: UILabel!
    
    var dataController = DataController()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateChart()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func goodButtonTapped() {
        tryAddMood(.Good)
    }
    
    @IBAction func badButtonTapped() {
        tryAddMood(.Bad)
    }
    
    func tryAddMood(mood: Mood) {
        let didAdd = self.dataController.addMood(mood)
        updateChart()
        
        let moodMessage = mood == .Good ? ":)" : ":/"
        displayMessageOrTimer(didAdd ? moodMessage : nil)
    }
    
    func updateChart() {
        self.timeChart.setDay(dataController.today)
    }
    
    func displayMessageOrTimer(message: String?) {
        var timeIntervalString = String(ceil(self.dataController.today.timeIntervalUntilNextMoodAddition))
        timeIntervalString = "\(timeIntervalString) until next vote"
        displayMessage(message ?? timeIntervalString)
    }
    
    func displayMessage(message: String) {
        self.descriptionLabel.text = message
        
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC) * 2)
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.descriptionLabel.text = "How are you feeling?"
        }
    }
}

