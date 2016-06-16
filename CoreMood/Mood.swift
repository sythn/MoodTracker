//
//  Mood.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 01/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public enum Mood: Double, CustomStringConvertible {
    case good = 1
    case bad = 0
    case neutral = 0.5
    
    public var description: String {
        switch self {
        case .good:
            return "Good"
            
        case .neutral:
            return "Neutral"
            
        case .bad:
            return "Bad"
        }
    }
}
