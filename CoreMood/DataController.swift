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
        let data = AppConfiguration.sharedConfiguration.applicationUserDefaults.object(forKey: "SampleDays") as? Data
        if let data = data where data.count > 0,
            let days = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Day] {
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
        
        AppConfiguration.sharedConfiguration.applicationUserDefaults.addObserver(self, forKeyPath: "SampleDays", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: AnyObject?, change: [NSKeyValueChangeKey : AnyObject]?, context: UnsafeMutablePointer<Void>?) {
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
    
    public func addMood(_ mood: Mood) -> Bool {
        let didAdd = self.today.addMood(mood)
        persistDays()
        return didAdd
    }
    
    func persistDays() {
        let days = self.days.map { _, day in
            return day
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: days)
        AppConfiguration.sharedConfiguration.applicationUserDefaults.set(data, forKey: "SampleDays")
        AppConfiguration.sharedConfiguration.applicationUserDefaults.synchronize()
    }
}
