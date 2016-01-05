//
//  DataController.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 24/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public struct DataControllerUtilities {
    static func daysFromUserDefaults() -> [DayDate: Day]? {
        let data = NSUserDefaults.standardUserDefaults().objectForKey("SampleDays") as? NSData
        if let data = data where data.length > 0,
            let days = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Day] {
                var dayDict = [DayDate: Day]()
                for day in days {
                    dayDict[day.date] = day
                }
                return dayDict
        }
        
        return nil
    }
}

public protocol DataControllerDelegate {
    func didRefreshData()
}

public class DataController: NSObject {
    public var days: [DayDate: Day]
    public var delegate: DataControllerDelegate?
    
    public override init() {
        if let dayDict = DataControllerUtilities.daysFromUserDefaults() {
            self.days = dayDict
        } else {
            days = [DayDate: Day]()
        }
        
        super.init()
        
        NSUserDefaults.standardUserDefaults().addObserver(self, forKeyPath: "SampleDays", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let days = DataControllerUtilities.daysFromUserDefaults() {
            self.days = days
            self.delegate?.didRefreshData()
        }
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
