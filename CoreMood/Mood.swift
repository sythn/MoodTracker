//
//  Mood.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 01/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public enum Mood: Double, CustomStringConvertible {
    case Good = 1
    case Bad = 0
    case Neutral = 0.5
    
    public var description: String {
        switch self {
        case .Good:
            return "Good"
            
        case .Neutral:
            return "Neutral"
            
        case .Bad:
            return "Bad"
        }
    }
}