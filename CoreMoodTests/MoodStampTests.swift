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
        let now = Date()
        let stamp = MoodStamp(mood: .bad, timestamp: now)
        
        XCTAssert(stamp.mood == .bad)
        XCTAssert(stamp.timestamp == now)
    }
    
    func testDefaultValues() {
        let stamp = MoodStamp(mood: .bad)
        
        XCTAssert(stamp.mood == .bad)
        XCTAssertEqualWithAccuracy(stamp.timestamp.timeIntervalSinceNow, 0, accuracy: 1, "Timestamp should be accurate enough")
    }
    
    func testEquality() {
        let now = Date()
        
        let control = MoodStamp(mood: .bad, timestamp: now)
        
        let stamp1 = MoodStamp(mood: .bad, timestamp: now)
        let stamp2 = MoodStamp(mood: .good, timestamp: now)
        let stamp3 = MoodStamp(mood: .good)
        let stamp4 = MoodStamp(mood: .bad)
        let stamp5 = MoodStamp(mood: .neutral)
        
        XCTAssertEqual(control, stamp1)
        XCTAssertNotEqual(control, stamp2)
        XCTAssertNotEqual(control, stamp3)
        XCTAssertNotEqual(control, stamp4)
        XCTAssertNotEqual(control, stamp5)
    }
    
    func testEncoding() {
        let stamp = MoodStamp(mood: .bad)
        
        let stampData = NSKeyedArchiver.archivedData(withRootObject: stamp)
        XCTAssertNotNil(stampData)
        XCTAssertGreaterThan(stampData.count, 0, "Encoded data must contain data")
        
        let decodedStamp = NSKeyedUnarchiver.unarchiveObject(with: stampData) as? MoodStamp
        XCTAssertNotNil(decodedStamp)
        
        if let decodedStamp = decodedStamp {
            XCTAssertEqual(decodedStamp, stamp, "Stamp and decoded stamp must be equal")
        }
    }

}
