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
        
        let gPercentage = self.percentage
        let rPercentage = (1 - self.percentage)
        return UIColor(
            red: CGFloat(rPercentage * redR + gPercentage * greenR),
            green: CGFloat(rPercentage * redG + gPercentage * greenG),
            blue: CGFloat(rPercentage * redB + gPercentage * greenB),
            alpha: 1)
    }
}

extension Day {
    var timeScaleDataPoints: [TimeScaleDataPoint] {
        let moodPerHours = self.statistics.moodValuePerHours
        return (0..<24).map { hour in
            if let value = moodPerHours[hour] {
                return value
            }
            return MoodValue(values: [])
        }
    }
}

extension TimeScaleView {
    func setDay(day: Day) {
        self.dataPoints = day.timeScaleDataPoints
    }
}