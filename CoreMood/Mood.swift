//
//  Mood.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 01/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public enum Mood: Int, CustomStringConvertible {
    case Good = 1
    case Bad = 0
    
    public var description: String {
        return self == .Good ? "Good" : "Bad"
    }
}