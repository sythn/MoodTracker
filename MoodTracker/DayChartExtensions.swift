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
        return CGFloat(min(self.scale * 2, 1))
    }
    
    public var color: UIColor {
        let redHue = 0.0
        let greenHue = 0.3
        let saturation: CGFloat = 1
        let brightness: CGFloat = 0.759
        
        let greenPercentage = self.percentage
        let redPercentage = (1 - self.percentage)
        return UIColor(hue: CGFloat(redHue * redPercentage + greenHue * greenPercentage), saturation: saturation, brightness: brightness, alpha: 1)
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