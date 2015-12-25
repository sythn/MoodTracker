//
//  DateTests.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 24/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import XCTest
import CoreMood

class DateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNSDateConverting() {
        let date = NSDate()
        let dayDate = DayDate(date: date)
        
        let dateBack = dayDate.date

        XCTAssertNotNil(dateBack, "Day should not be nil: \(dayDate)")
        if let dateBack = dateBack {
            XCTAssertTrue(NSCalendar.currentCalendar().isDate(date, inSameDayAsDate: dateBack), "Dates should be in same day")
        }
    }
    
    func testNSDateComponentsConverting() {
        let components = NSDateComponents()
        components.day = 17
        components.month = 7
        components.year = 3434
        components.hour = 23
        components.minute = 59
        
        let dayDate = DayDate(dateComponents: components)
        let componentsBack = dayDate.dateComponents
        
        XCTAssertEqual(components.day, componentsBack.day, "Days should be equal")
        XCTAssertEqual(components.month, componentsBack.month, "Months should be equal")
        XCTAssertEqual(components.year, componentsBack.year, "Years should be equal")
        
        let date1 = NSCalendar.currentCalendar().dateFromComponents(components)
        let date2 = NSCalendar.currentCalendar().dateFromComponents(componentsBack)
        
        XCTAssertNotNil(date1 ?? date2, "Dates should not be nil")
        if let date1 = date1, let date2 = date2 {
            XCTAssertTrue(NSCalendar.currentCalendar().isDate(date1, inSameDayAsDate: date2), "Dates should be in same day")
        }
    }
    
}
