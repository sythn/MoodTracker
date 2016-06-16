//
//  MoodPercentage.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 22/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public struct MoodValue: CustomStringConvertible {
    public var values: [Double]
    
    public init(values: [Double]) {
        self.values = values
    }
    
    public var scale: Double {
        return Double(values.count) / (60 / 5)
    }
    
    public var _scale: Double {
        return Double(values.count) / (60 / 5)
    }
    
    public var dayScale: Double {
        return Double(values.count) / (60 * 24 / 5)
    }
    
    public var percentage: Double {
        return Double(values.reduce(0, combine: {$0 + $1})) / Double(values.count)
    }
    
    public var description: String {
        return "Mood value: \(percentage * 100)% with \(values.count) value count"
    }
}
