//
//  MoodStamp.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 01/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

public final class MoodStamp: NSObject, NSCoding {
    public var mood: Mood
    public var timestamp: NSDate
    
    public init(mood: Mood, timestamp: NSDate = NSDate()) {
        self.mood = mood
        self.timestamp = timestamp
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        guard let mood = Mood(rawValue: aDecoder.decodeDoubleForKey(Keys.Mood)),
            let timestamp = aDecoder.decodeObjectForKey(Keys.Timestamp) as? NSDate else {
                self.mood = .Good
                self.timestamp = NSDate()
                super.init()
                return nil
        }
        
        self.mood = mood
        self.timestamp = timestamp
        super.init()
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(self.mood.rawValue, forKey: Keys.Mood)
        aCoder.encodeObject(self.timestamp, forKey: Keys.Timestamp)
    }
    
    public override func isEqual(object: AnyObject?) -> Bool {
        guard let otherStamp = object as? MoodStamp else {
            return false
        }
        
        return self.mood == otherStamp.mood && self.timestamp == otherStamp.timestamp
    }
    
    override public var description: String {
        return "Mood stamp: \(self.mood), \(self.timestamp)"
    }
}

extension MoodStamp {
    private struct Keys {
        static let Mood = "Mood"
        static let Timestamp = "Timestamp"
    }
}