//
//  TimeScaleDataPoint.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 22/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit

public protocol TimeScaleDataPoint {
    var scale: CGFloat { get }
    var value: CGFloat { get }
    
    var color: UIColor { get }
}
