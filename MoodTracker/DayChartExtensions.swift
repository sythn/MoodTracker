//
//  DayChartExtensions.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 25/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation
import Charts
import CoreMood

extension MoodValue: TimeScaleDataPoint {
    public var value: CGFloat {
        return 1
    }
    
    public var scale: CGFloat {
        return CGFloat(self.scale)
    }
    
    public var color: UIColor {
        let redR = 0.759
        let redG = 0.0
        let redB = 0.0
        
        let greenR = 0.0
        let greenG = 0.759
        let greenB = 0.103
        
        let percentage = self.percentage
        return UIColor(
            red: CGFloat(redR + percentage * greenR),
            green: CGFloat(redG + percentage * greenG),
            blue: CGFloat(redB + percentage * greenB),
            alpha: 1)
    }
}