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
    
    var pageLayout: CollectionViewPageFlowLayout!
    var gridLayout: CollectionViewGridLayout!
    
    var dataController = DataController()
    var daysInOrder: [Day] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataController.delegate = self
        
        updateChart()
        setUpCollectionView()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("doubleTap:"))
        tapRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapRecognizer)
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
    
    var isOnGridLayout = false
    func doubleTap(recognizer: UITapGestureRecognizer) {
        if isOnGridLayout {
            self.collectionView.collectionViewLayout = self.pageLayout
            self.isOnGridLayout = false
        } else {
            self.collectionView.collectionViewLayout = self.gridLayout
            self.isOnGridLayout = true
        }
        
        self.collectionView.reloadData()
        self.scrollToLastPageAnimated(false)
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
        self.pageLayout = CollectionViewPageFlowLayout()
        self.gridLayout = CollectionViewGridLayout()
        
        self.collectionView.collectionViewLayout = self.pageLayout
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
            
            if self.isOnGridLayout {
                timeScaleCell.timeScaleView.insideScale = 0.6
                timeScaleCell.timeScaleView.minScale = 0.7
            } else {
                timeScaleCell.timeScaleView.insideScale = 0.3
                timeScaleCell.timeScaleView.minScale = 0.5
            }
        }
    }
}

