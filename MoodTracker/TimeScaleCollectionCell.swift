//
//  TimeScaleCollectionCell.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 26/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit
import CoreMood
import Charts

class TimeScaleCollectionCell: UICollectionViewCell {
    var timeScaleView = TimeScaleView()
    
    var day: Day? {
        didSet {
            if let day = day {
                self.timeScaleView.setDay(day)
                self.timeScaleView.alpha = 1
            } else {
                self.timeScaleView.alpha = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpTimeScaleView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpTimeScaleView()
    }
    
    func setUpTimeScaleView() {
        self.timeScaleView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.timeScaleView)
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[scaleView]-|", options: [], metrics: nil, views: ["scaleView": self.timeScaleView]))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[scaleView]-|", options: [], metrics: nil, views: ["scaleView": self.timeScaleView]))
    }
}
