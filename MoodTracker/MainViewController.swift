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

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, DataControllerDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var descriptionLabel: UILabel!
    
    var dataController = DataController()
    var daysInOrder: [Day] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataController.delegate = self
        
        updateChart()
        setUpCollectionView()
    }
    
    func didRefreshData() {
        updateChart()
    }
    
    override func viewDidAppear(animated: Bool) {
        scrollToLastPageAnimated(animated)
        
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func goodButtonTapped() {
        tryAddMood(.Good)
    }
    
    @IBAction func neutralButtonTapped() {
        tryAddMood(.Neutral)
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
    
    private let TimeScaleCollectionViewReuseIdentifier = "TimeScaleCollectionView"
    func setUpCollectionView() {
        self.collectionView.collectionViewLayout = CollectionViewPageFlowLayout()
        self.collectionView.registerClass(TimeScaleCollectionCell.self, forCellWithReuseIdentifier: TimeScaleCollectionViewReuseIdentifier)
    }
    
    func updateDaysInOrder() {
        var days = Array(self.dataController.days.values)
        days.sortInPlace { first, second in
            return first.date < second.date
        }
        self.daysInOrder = days
    }
    
    func updateChart() {
        updateDaysInOrder()
        self.collectionView.reloadData()
        
        scrollToLastPageAnimated(true)
    }
    
    func scrollToLastPageAnimated(animated: Bool) {
        let lastPage = self.collectionView.pageCount - 1
        self.collectionView.setPageIndex(lastPage, animated: animated)
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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.daysInOrder.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(TimeScaleCollectionViewReuseIdentifier, forIndexPath: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if let timeScaleCell = cell as? TimeScaleCollectionCell {
            let day = self.daysInOrder[indexPath.row]
            timeScaleCell.day = day
        }
    }
}

