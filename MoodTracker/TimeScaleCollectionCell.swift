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
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
