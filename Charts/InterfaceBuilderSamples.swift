//
//  InterfaceBuilderSamples.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 24/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

struct SampleTimeScaleDataPoint: TimeScaleDataPoint {
    var scale: CGFloat
    var value: CGFloat
    
    var color: UIColor
}

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
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: green1),
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: UIColor.greenColor()),
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: UIColor.purpleColor()),
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: UIColor.yellowColor()),
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: UIColor.blueColor()),
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: UIColor.greenColor()),
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: UIColor.purpleColor()),
            SampleTimeScaleDataPoint(scale: 1/12, value: 1, color: red1),
            SampleTimeScaleDataPoint(scale: 3/12, value: 1, color: red1),
            SampleTimeScaleDataPoint(scale: 5/12, value: 1, color: yellow1),
            SampleTimeScaleDataPoint(scale: 1/12, value: 1, color: red2),
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: yellow2),
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: green1),
            SampleTimeScaleDataPoint(scale: 3/12, value: 1, color: green1),
            SampleTimeScaleDataPoint(scale: 1/12, value: 1, color: yellow2),
            SampleTimeScaleDataPoint(scale: 1/12, value: 1, color: yellow3),
            SampleTimeScaleDataPoint(scale: 12/12, value: 1, color: red2),
            SampleTimeScaleDataPoint(scale: 4/12, value: 1, color: yellow2),
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: green2),
            SampleTimeScaleDataPoint(scale: 7/12, value: 1, color: green2),
            SampleTimeScaleDataPoint(scale: 1/12, value: 1, color: green1),
            SampleTimeScaleDataPoint(scale: 0, value: 1, color: yellow3),
            SampleTimeScaleDataPoint(scale: 3/12, value: 1, color: yellow2),
            SampleTimeScaleDataPoint(scale: 1/12, value: 1, color: yellow1),
            SampleTimeScaleDataPoint(scale: 2/12, value: 1, color: yellow1)
        ]
    }
}