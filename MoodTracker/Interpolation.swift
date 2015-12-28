//
//  Interpolation.swift
//  Math
//
//  Created by Seyithan Teymur on 16/02/15.
//  Copyright (c) 2015 OneV's Den. All rights reserved.
//

import Foundation

public protocol Interpolatable {
    func interpolateLinearlyTo(other: Self, through: Double) -> Self
}

public struct Interpolation<Item where Item: Interpolatable> {
    public let values: [Item]
    public let points: [Double]
    
    public init(_ values: [Item], points: [Double]? = nil) {
        self.values = values
        
        var _points: [Double]
        
        if points != nil && points?.count == values.count {
            _points = points!
        } else {
            _points = [Double]()
            for i in 0..<values.count {
                _points.append(Double(i)/Double(values.count - 1))
            }
        }
        
        self.points = _points
    }
    
    public init(_ _values: [Double: Item]) {
        let sortedPoints = Array(_values.keys).sort({ $0 < $1 })
        var values = [Item]()
        
        for point in sortedPoints {
            values.append(_values[point]!)
        }
        
        self.points = sortedPoints
        self.values = values
    }
    
    public subscript(point: Double) -> Item {
        get {
            if !point.isFinite {
                return interpolatedValueForPoint(self.points[0])
            }
            return interpolatedValueForPoint(point)
        }
    }
    
    private func interpolatedValueForPoint(point: Double) -> Item {
        if point <= 0 {
            return self.values[0]
        } else if point >= self.points.last! {
            return self.values.last!
        }
        
        var floorPoint = points.first!
        var floorIndex = 0
        
        for (index, currentPoint) in points.enumerate() {
            if currentPoint > point {
                break
            }
            floorPoint = currentPoint
            floorIndex = index
        }
        
        if floorPoint == point {
            return values[floorIndex]
        }
        
        let ceilingPoint = points[floorIndex + 1]
        let through = (point - floorPoint) / (ceilingPoint - floorPoint)
        let floorValue = values[floorIndex], ceilingValue = values[floorIndex + 1]
        
        return floorValue.interpolateLinearlyTo(ceilingValue, through: through)
    }

}
