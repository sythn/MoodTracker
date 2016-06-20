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
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainViewController.doubleTap(_:)))
        tapRecognizer.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tapRecognizer)
        
        NotificationCenter.default().addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) { (notification) in
            self.updateChart()
        }
    }
    
    func didRefreshData() {
        updateChart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollToLastPageAnimated(animated)
        
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var isOnGridLayout = false
    func doubleTap(_ recognizer: UITapGestureRecognizer) {
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
        tryAddMood(.good)
    }
    
    @IBAction func neutralButtonTapped() {
        tryAddMood(.neutral)
    }
    
    @IBAction func badButtonTapped() {
        tryAddMood(.bad)
    }
    
    func tryAddMood(_ mood: Mood) {
        let didAdd = self.dataController.addMood(mood)
        updateChart()
        
        let moodMessage = mood == .good ? ":)" : ":/"
        displayMessageOrTimer(didAdd ? moodMessage : nil)
    }
    
    private let TimeScaleCollectionViewReuseIdentifier = "TimeScaleCollectionView"
    func setUpCollectionView() {
        self.pageLayout = CollectionViewPageFlowLayout()
        self.gridLayout = CollectionViewGridLayout()
        
        self.collectionView.collectionViewLayout = self.pageLayout
        self.collectionView.register(TimeScaleCollectionCell.self, forCellWithReuseIdentifier: TimeScaleCollectionViewReuseIdentifier)
    }
    
    func updateDaysInOrder() {
        var days = Array(self.dataController.days.values)
        days.sort { first, second in
            return first.date < second.date
        }
        self.daysInOrder = days
    }
    
    func updateChart() {
        updateDaysInOrder()
        self.collectionView.reloadData()
        
        scrollToLastPageAnimated(true)
    }
    
    func scrollToLastPageAnimated(_ animated: Bool) {
        let lastPage = self.collectionView.pageCount - 1
        self.collectionView.setPageIndex(lastPage, animated: animated)
    }
    
    func displayMessageOrTimer(_ message: String?) {
        var timeIntervalString = String(ceil(self.dataController.today.timeIntervalUntilNextMoodAddition))
        timeIntervalString = "\(timeIntervalString) until next vote"
        displayMessage(message ?? timeIntervalString)
    }
    
    func displayMessage(_ message: String) {
        self.descriptionLabel.text = message
        
        let dispatchTime = DispatchTime.now() + Double(Int64(NSEC_PER_SEC) * 2) / Double(NSEC_PER_SEC)
        DispatchQueue.main.after(when: dispatchTime) {
            self.descriptionLabel.text = "How are you feeling?"
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.daysInOrder.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: TimeScaleCollectionViewReuseIdentifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let timeScaleCell = cell as? TimeScaleCollectionCell {
            let day = self.daysInOrder[(indexPath as NSIndexPath).row]
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

