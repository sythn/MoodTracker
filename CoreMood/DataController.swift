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
        let data = NSUserDefaults.standardUserDefaults().objectForKey("SampleDays") as? NSData
        if let data = data where data.length > 0,
            let days = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Day] {
                var dayDict = [DayDate: Day]()
                for day in days {
                    dayDict[day.date] = day
                }
                self.days = dayDict
        } else {
            days = [DayDate: Day]()
        }
        
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
        let didAdd = self.today.addMood(mood)
        persistDays()
        return didAdd
    }
    
    func persistDays() {
        let days = self.days.map { _, day in
            return day
        }
        let data = NSKeyedArchiver.archivedDataWithRootObject(days)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "SampleDays")
    }
}
