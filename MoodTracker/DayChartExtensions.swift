//
//  DayChartExtensions.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 25/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit
import Charts
import CoreMood

let colorInterpolation = Interpolation([
    0: UIColor(red:1, green:0.15, blue:0.071, alpha:1),
    0.5: UIColor(red:0.94, green:0.873, blue:0, alpha:1),
    1: UIColor(red:0.003, green:0.874, blue:0, alpha:1)
])

extension MoodValue: TimeScaleDataPoint {
    public var value: CGFloat {
        return 1
    }
    
    public var scale: CGFloat {
        return CGFloat(min(self.scale * 2, 1))
    }
    
    public var color: UIColor {
        return colorInterpolation[self.percentage]
    }
}

extension UIColor: Interpolatable {
    public func interpolateLinearlyTo(other: UIColor, through: Double) -> Self {

        var hue1: CGFloat = 0
        var saturation1: CGFloat = 0
        var value1: CGFloat = 0
        var alpha1: CGFloat = 0
        
        var hue2: CGFloat = 0
        var saturation2: CGFloat = 0
        var value2: CGFloat = 0
        var alpha2: CGFloat = 0
        
        getHue(&hue1, saturation: &saturation1, brightness: &value1, alpha: &alpha1)
        other.getHue(&hue2, saturation: &saturation2, brightness: &value2, alpha: &alpha2)
        
        let throughF = CGFloat(through)
        let hue = hue1 + (hue2 - hue1) * throughF
        let saturation = saturation1 + (saturation2 - saturation1) * throughF
        let value = value1 + (value2 - value1) * throughF
        let alpha = alpha1 + (alpha2 - alpha1) * throughF
        
        return self.dynamicType.init(hue: hue, saturation: saturation, brightness: value, alpha: alpha)
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
    
    var circleColor: UIColor {
        return colorInterpolation[self.statistics.moodValue.percentage]
    }
}

extension TimeScaleView {
    func setDay(day: Day) {
        self.circleColor = day.circleColor
        self.dataPoints = day.timeScaleDataPoints
    }
}