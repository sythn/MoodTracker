//
//  DataController.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 24/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public class DataController: NSObject {
    public var days: [DayDate: Day]
    
    public override init() {
        days = [DayDate: Day]()
        
        super.init()
    }
    
    public var today: Day {
        if let today = days[DayDate()] {
            return today
        }
        
        let today = Day()
        days[DayDate()] = today
        return today
    }
    
    public func addMood(mood: Mood) -> Bool {
        return self.today.addMood(mood)
    }
}
