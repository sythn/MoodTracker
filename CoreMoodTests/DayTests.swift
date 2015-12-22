//
//  DayTests.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 22/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import XCTest
import CoreMood

class DayTests: XCTestCase {
    
    var sampleMoodStamp: MoodStamp {
        let good = arc4random_uniform(2) == 0
        let timeInterval = Double(-60 * Int(arc4random_uniform(10)))
        
        let timestamp = NSDate(timeIntervalSinceNow: timeInterval)
        return MoodStamp(mood: good ? .Good : .Bad, timestamp: timestamp)
    }
    
    func sampleMoodArrayWithCount(count: Int) -> [MoodStamp] {
        if count < 1 {
            return []
        }
        
        return (0..<count).map { _ in
            self.sampleMoodStamp
        }
    }

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValues() {
        let stampArray = self.sampleMoodArrayWithCount(2)
        let day = Day(moodStamps: stampArray)
        
        XCTAssertEqual(day.moodStamps.count, stampArray.count)
    }
    
    func testDefaultValues() {
        let day = Day()
        XCTAssertNotNil(day.moodStamps, "Day's stamp array should not be nil")
        XCTAssertEqual(day.moodStamps.count, 0, "Day's stamp array should have an object count of 0")
    }
    
    func testEncoding() {
        let stampArray = self.sampleMoodArrayWithCount(2)
        let day = Day(moodStamps: stampArray)
        
        let dayData = NSKeyedArchiver.archivedDataWithRootObject(day)
        XCTAssertGreaterThan(dayData.length, 0, "Encoded data should not be empty")
        
        let decodedDay = NSKeyedUnarchiver.unarchiveObjectWithData(dayData) as? Day
        XCTAssertNotNil(decodedDay, "Decoded day should not be nil")
        
        if let decodedDay = decodedDay {
            XCTAssertEqual(day, decodedDay, "Day and decoded day should be equal")
            XCTAssertEqual(decodedDay.moodStamps.count, stampArray.count, "Decoded day's stamp array should be equal to the original stamp array")
        }
    }
    
    func testMoodAddition() {
        let day = Day()
        
        for i in 0..<1 {
            let mood = i%2 == 0 ? Mood.Good : Mood.Bad
            day.addMood(mood)
            
            XCTAssertEqual(day.moodStamps.count, i+1, "Mood (\(i)) should be added")
            XCTAssertEqual(day.lastMoodStamp?.mood, mood, "Last moodstamp's mood should be equal to the last added mood")
        }
        
        XCTAssertEqual(day.moodStamps.count, 1, "Day should have 10 mood stamps")
    }
    
    func testMoodSorting() {
        let firstMoodStamp = MoodStamp(mood: .Good, timestamp: NSDate(timeIntervalSinceNow: -10*60))
        let secondMoodStamp = MoodStamp(mood: .Good)
        
        let day = Day(moodStamps: [secondMoodStamp, firstMoodStamp])
        XCTAssertEqual(day.lastMoodStamp, secondMoodStamp, "Day should have sorted moodstamps on init")
        
        let day2 = Day(moodStamps: [firstMoodStamp])
        day2.addMood(.Bad)
        XCTAssertNotEqual(day2.lastMoodStamp, firstMoodStamp, "Day should sort moodstamps on addition")
    }
    
    func testMoodFrequencyCap() {
        let day = Day()
        
        let addFirst = day.addMood(.Good)
        let addSecond = day.addMood(.Good)
        
        XCTAssertTrue(addFirst, "Day should add the first mood")
        XCTAssertFalse(addSecond, "Day should not add the second mood")
        
        XCTAssertEqual(day.moodStamps.count, 1, "Day moodstamp count should be 1")
    }
    
    func testDefaultMoodAdditionInterval() {
        let day = Day()
        
        let now = NSDate()
        day.addMood(.Good)
        let timeIntervalUntilNextAddition = day.timeIntervalUntilNextMoodAddition
        
        XCTAssertEqualWithAccuracy(now.timeIntervalSinceNow, day.lastMoodStamp!.timestamp.timeIntervalSinceNow, accuracy: 1, "Day's last added mood time stamp should be now")
        XCTAssertEqualWithAccuracy(5*60, timeIntervalUntilNextAddition, accuracy: 2, "Time interval until next mood addition should be close to 5 mins")
        
        XCTAssertFalse(day.addMood(.Good))
    }
    
    func testPastMoodAdditionInterval() {
        let pastMood = MoodStamp(mood: .Good, timestamp: NSDate(timeIntervalSinceNow: -4*60))
        let day = Day(moodStamps: [pastMood])
        let timeIntervalUntilNextAddition = day.timeIntervalUntilNextMoodAddition
        
        XCTAssertEqualWithAccuracy(1*60, timeIntervalUntilNextAddition, accuracy: 2, "Time interval until next mood addition should be close to 1 min")
        
        XCTAssertFalse(day.addMood(.Good))
    }

}
