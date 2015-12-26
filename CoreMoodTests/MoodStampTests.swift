//
//  MoodStampTests.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 21/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import XCTest
import CoreMood

class MoodStampTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValues() {
        let now = NSDate()
        let stamp = MoodStamp(mood: .Bad, timestamp: now)
        
        XCTAssert(stamp.mood == .Bad)
        XCTAssert(stamp.timestamp == now)
    }
    
    func testDefaultValues() {
        let stamp = MoodStamp(mood: .Bad)
        
        XCTAssert(stamp.mood == .Bad)
        XCTAssertEqualWithAccuracy(stamp.timestamp.timeIntervalSinceNow, 0, accuracy: 1, "Timestamp should be accurate enough")
    }
    
    func testEquality() {
        let now = NSDate()
        
        let control = MoodStamp(mood: .Bad, timestamp: now)
        
        let stamp1 = MoodStamp(mood: .Bad, timestamp: now)
        let stamp2 = MoodStamp(mood: .Good, timestamp: now)
        let stamp3 = MoodStamp(mood: .Good)
        let stamp4 = MoodStamp(mood: .Bad)
        let stamp5 = MoodStamp(mood: .Neutral)
        
        XCTAssertEqual(control, stamp1)
        XCTAssertNotEqual(control, stamp2)
        XCTAssertNotEqual(control, stamp3)
        XCTAssertNotEqual(control, stamp4)
        XCTAssertNotEqual(control, stamp5)
    }
    
    func testEncoding() {
        let stamp = MoodStamp(mood: .Bad)
        
        let stampData = NSKeyedArchiver.archivedDataWithRootObject(stamp)
        XCTAssertNotNil(stampData)
        XCTAssertGreaterThan(stampData.length, 0, "Encoded data must contain data")
        
        let decodedStamp = NSKeyedUnarchiver.unarchiveObjectWithData(stampData) as? MoodStamp
        XCTAssertNotNil(decodedStamp)
        
        if let decodedStamp = decodedStamp {
            XCTAssertEqual(decodedStamp, stamp, "Stamp and decoded stamp must be equal")
        }
    }

}
