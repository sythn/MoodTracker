//
//  Day.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 01/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public final class Day: NSObject, NSCoding {
    public let moodAdditionIntervalCap: TimeInterval = 5 * 60
    
    public var moodStamps: [MoodStamp]
    public var date: DayDate
    
    public init(moodStamps: [MoodStamp] = [], date: Date = Date()) {
        self.moodStamps = moodStamps
        self.date = DayDate(date: date)
        super.init()
        
        self.sortMoods()
    }
    
    private func sortMoods() {
        self.moodStamps.sort { (first, second) -> Bool in
            return first.timestamp.compare(second.timestamp as Date) == .orderedAscending
        }
    }
    
    public var lastMoodStamp: MoodStamp? {
        return moodStamps.last
    }
    
    public var timeIntervalUntilNextMoodAddition: TimeInterval {
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
    
    public func addMood(_ mood: Mood) -> Bool {
        if canAddMood {
            let stamp = MoodStamp(mood: mood, timestamp: Date())
            moodStamps.append(stamp)
            self.sortMoods()
            
            return true
        }
        return false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        guard let stamps = aDecoder.decodeObject(forKey: Keys.MoodStamps) as? [MoodStamp],
            let dateComponents = aDecoder.decodeObject(forKey: Keys.Date) as? DateComponents
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
    
    @objc(encodeWithCoder:) public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.moodStamps, forKey: Keys.MoodStamps)
        aCoder.encode(self.date.dateComponents, forKey: Keys.Date)
    }
    
    public override func isEqual(_ object: AnyObject?) -> Bool {
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
