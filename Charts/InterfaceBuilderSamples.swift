//
//  InterfaceBuilderSamples.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 24/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

extension TimeScaleView {
    public override func prepareForInterfaceBuilder() {
        let red1 = UIColor(red:0.775, green:0.074, blue:0.054, alpha:1)
        let red2 = UIColor(red:0.775, green:0.243, blue:0.054, alpha:1)
        let yellow1 = UIColor(red:0.775, green:0.518, blue:0.054, alpha:1)
        let yellow2 = UIColor(red:0.775, green:0.715, blue:0.054, alpha:1)
        let yellow3 = UIColor(red:0.728, green:0.775, blue:0.054, alpha:1)
        let green1 = UIColor(red:0.564, green:0.775, blue:0.054, alpha:1)
        let green2 = UIColor(red:0.2, green:0.775, blue:0.054, alpha:1)
        
        self.dataPoints = [
            TimeScaleDataPoint(scale: 0, value: 1, color: green1),
            TimeScaleDataPoint(scale: 0, value: 1, color: UIColor.greenColor()),
            TimeScaleDataPoint(scale: 0, value: 1, color: UIColor.purpleColor()),
            TimeScaleDataPoint(scale: 0, value: 1, color: UIColor.yellowColor()),
            TimeScaleDataPoint(scale: 0, value: 1, color: UIColor.blueColor()),
            TimeScaleDataPoint(scale: 0, value: 1, color: UIColor.greenColor()),
            TimeScaleDataPoint(scale: 0, value: 1, color: UIColor.purpleColor()),
            TimeScaleDataPoint(scale: 1/12, value: 1, color: red1),
            TimeScaleDataPoint(scale: 3/12, value: 1, color: red1),
            TimeScaleDataPoint(scale: 5/12, value: 1, color: yellow1),
            TimeScaleDataPoint(scale: 1/12, value: 1, color: red2),
            TimeScaleDataPoint(scale: 0, value: 1, color: yellow2),
            TimeScaleDataPoint(scale: 0, value: 1, color: green1),
            TimeScaleDataPoint(scale: 3/12, value: 1, color: green1),
            TimeScaleDataPoint(scale: 1/12, value: 1, color: yellow2),
            TimeScaleDataPoint(scale: 1/12, value: 1, color: yellow3),
            TimeScaleDataPoint(scale: 12/12, value: 1, color: red2),
            TimeScaleDataPoint(scale: 4/12, value: 1, color: yellow2),
            TimeScaleDataPoint(scale: 0, value: 1, color: green2),
            TimeScaleDataPoint(scale: 7/12, value: 1, color: green2),
            TimeScaleDataPoint(scale: 1/12, value: 1, color: green1),
            TimeScaleDataPoint(scale: 1/12, value: 1, color: green2),
            TimeScaleDataPoint(scale: 0, value: 1, color: yellow3),
            TimeScaleDataPoint(scale: 3/12, value: 1, color: yellow2)
        ]
    }
}