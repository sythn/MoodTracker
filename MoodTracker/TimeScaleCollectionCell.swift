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
    var dateLabel = UILabel()
    
    var dateFormatter = NSDateFormatter()
    
    var day: Day? {
        didSet {
            if let day = day {
                self.timeScaleView.setDay(day)
                self.timeScaleView.alpha = 1
            } else {
                self.timeScaleView.alpha = 0
            }
            
            if let date = day?.date.date {
                self.dateLabel.text = self.dateFormatter.stringFromDate(date)
                self.dateLabel.alpha = 1
            } else {
                self.dateLabel.alpha = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpDateFormatter()
        setUpSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUpDateFormatter()
        setUpSubviews()
    }
    
    func setUpDateFormatter() {
        self.dateFormatter.setLocalizedDateFormatFromTemplate("dMMME")
//        self.dateFormatter.doesRelativeDateFormatting = true
    }
    
    func setUpSubviews() {
        self.timeScaleView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.timeScaleView)
        
        self.dateLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        self.dateLabel.textAlignment = .Center
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.dateLabel)
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[scaleView]-|", options: [], metrics: nil, views: ["scaleView": self.timeScaleView]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[date]-|", options: [], metrics: nil, views: ["date": self.dateLabel]))
        
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[date]-[scaleView]-|", options: [], metrics: nil, views: ["date": self.dateLabel, "scaleView": self.timeScaleView]))
    }
}
