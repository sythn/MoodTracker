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
    public var timestamp: Date
    
    public init(mood: Mood, timestamp: Date = Date()) {
        self.mood = mood
        self.timestamp = timestamp
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        guard let mood = Mood(rawValue: aDecoder.decodeDouble(forKey: Keys.Mood)),
            let timestamp = aDecoder.decodeObject(forKey: Keys.Timestamp) as? Date else {
                self.mood = .good
                self.timestamp = Date()
                super.init()
                return nil
        }
        
        self.mood = mood
        self.timestamp = timestamp
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.mood.rawValue, forKey: Keys.Mood)
        aCoder.encode(self.timestamp, forKey: Keys.Timestamp)
    }
    
    public override func isEqual(_ object: AnyObject?) -> Bool {
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
