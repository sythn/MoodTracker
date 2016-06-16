//
//  MoodStatisticsTests.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 22/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import XCTest
import CoreMood

class MoodStatisticsTests: XCTestCase {
    
    var day: Day!
    
    func sampleDateForHour(_ hour: Int) -> Date {
        let trueHour = max(min(hour, 23), 0)
        return Calendar.current().date(bySettingUnit: .hour, value: trueHour, of: Date(), options: [])!
    }

    override func setUp() {
        super.setUp()
        
        var stamps = [MoodStamp]()
        
        for hour in 0..<24 {
            let good = MoodStamp(mood: .good, timestamp: self.sampleDateForHour(hour))
            let bad = MoodStamp(mood: .bad, timestamp: self.sampleDateForHour(hour))
            stamps.append(contentsOf: [good, bad])
        }
        
        day = Day(moodStamps: stamps)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCleanStatistics() {
        let statistics = Day().statistics
        
        XCTAssertEqual(statistics.moodValue.scale, 0, "Statistics scale should be 0")
        XCTAssertEqual(statistics.moodValue.values.count, 0, "Statistics mood value count should be 0")
        XCTAssertEqual(statistics.moodValuePerHours.count, 0, "Mood value per hours should be empty")
    }
    
    func testSingleValueStatistics() {
        let statistics = Day(moodStamps: [MoodStamp(mood: .neutral)]).statistics
        
        XCTAssertEqual(statistics.moodValue.scale, 1/12)
        XCTAssertEqual(statistics.moodValue.percentage, 1/2, "Mood value should be all \"good\"")
        XCTAssertEqual(statistics.moodValue.values.count, 1, "Statistics should have a single value")
        XCTAssertEqual(statistics.moodValuePerHours.count, 1, "Statistics should have a single day value")
    }
    
    func testMultipleValueStatistics() {
        
        let statistics = day.statistics
        
        XCTAssertEqual(statistics.moodValue.dayScale, 1/6, "Day should have 2 moods for every hour")
        XCTAssertEqual(statistics.moodValue.percentage, 1/2, "Good and bad moods should be of equal count")
        XCTAssertEqual(statistics.moodValue.values.count, 48, "Statistics should have 24 * 2 values")
        XCTAssertEqual(statistics.moodValuePerHours.count, 24, "Statistics should have a value for every hour")
        
        for (_, mood) in statistics.moodValuePerHours {
            XCTAssertEqual(mood.scale, 1/6, "Hour should have 2 moods")
            XCTAssertEqual(mood.percentage, 1/2, "Hour should have a good and a bad moods")
            XCTAssertEqual(mood.values.count, 2, "Hour should have 2 values")
        }
        
    }
    
    func testStatisticsPerformance() {
        
        self.measure {
            self.day.statistics
        }
        
    }
    
}
