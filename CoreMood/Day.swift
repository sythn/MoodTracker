//
//  Day.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 01/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public final class Day: NSObject, NSCoding {
    public let moodAdditionIntervalCap: NSTimeInterval = 5 * 60
    
    public var moodStamps: [MoodStamp]
    public var date: DayDate
    
    public init(moodStamps: [MoodStamp] = [], date: NSDate = NSDate()) {
        self.moodStamps = moodStamps
        self.date = DayDate(date: date)
        super.init()
        
        self.sortMoods()
    }
    
    private func sortMoods() {
        self.moodStamps.sortInPlace { (first, second) -> Bool in
            return first.timestamp.compare(second.timestamp) == .OrderedAscending
        }
    }
    
    public var lastMoodStamp: MoodStamp? {
        return moodStamps.last
    }
    
    public var timeIntervalUntilNextMoodAddition: NSTimeInterval {
        if let lastTimestamp = lastMoodStamp?.timestamp {
            let timeInterval = lastTimestamp.timeIntervalSinceNow * -1
            if timeInterval < moodAdditionIntervalCap {
                return moodAdditionIntervalCap - timeInterval
            }
        }
        return 0
    }
    
    public var canAddMood: Bool {
        return self.timeIntervalUntilNextMoodAddition == 0
    }
    
    public func addMood(mood: Mood) -> Bool {
        if canAddMood {
            let stamp = MoodStamp(mood: mood, timestamp: NSDate())
            moodStamps.append(stamp)
            self.sortMoods()
            
            return true
        }
        return false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        guard let stamps = aDecoder.decodeObjectForKey(Keys.MoodStamps) as? [MoodStamp],
            let dateComponents = aDecoder.decodeObjectForKey(Keys.Date) as? NSDateComponents
            else {
                self.moodStamps = []
                self.date = DayDate()
                super.init()
                return nil
        }
        self.moodStamps = stamps
        self.date = DayDate(dateComponents: dateComponents)
        super.init()
        
        self.sortMoods()
    }
}

public extension Day {
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.moodStamps, forKey: Keys.MoodStamps)
        aCoder.encodeObject(self.date.dateComponents, forKey: Keys.Date)
    }
    
    public override func isEqual(object: AnyObject?) -> Bool {
        guard let otherDay = object as? Day else {
            return false
        }
        
        return self.moodStamps == otherDay.moodStamps
    }
    
    public override var description: String {
        return "Day: \(self.moodStamps)"
    }
}

private extension Day {
    private struct Keys {
        static let MoodStamps = "MoodStamps"
        static let Date = "Date"
    }
}