//
//  MoodTests.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 21/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import XCTest
import CoreMood

class MoodTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testValues() {
        let good = Mood.good
        XCTAssert(good == .good)
        
        let bad = Mood.bad
        XCTAssert(bad == .bad)
        
        let neutral = Mood.neutral
        XCTAssert(neutral == .neutral)
    }

}
