//
//  DayDate.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 24/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

protocol DateConvertible {
    init(date: NSDate)
    var date: NSDate? { get }
}

protocol DateComponentsConvertible {
    init?(dateComponents: NSDateComponents)
    var dateComponents: NSDateComponents { get }
}

public struct DayDate: DateConvertible, DateComponentsConvertible {
    public var day: Int
    public var month: Int
    public var year: Int
    
    public init(day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    public init() {
        self.init(date: NSDate())
    }
    
    public init(dateComponents: NSDateComponents) {
        self.day = dateComponents.day
        self.month = dateComponents.month
        self.year = dateComponents.year
    }
    
    public init(date: NSDate) {
        let components = NSCalendar.currentCalendar().components([.Day, .Month, .Year], fromDate: date)
        self.init(dateComponents: components)
    }
    
    public func dateWithDaysAfter(daysAfter: Int) -> DayDate? {
        if let date = self.date,
            let newDate = NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: daysAfter, toDate: date, options: []) {
                return DayDate(date: newDate)
        }
        return nil
    }
    
    public var dateComponents: NSDateComponents {
        let components = NSDateComponents()
        components.day = day
        components.month = month
        components.year = year
        return components
    }
    
    public var date: NSDate? {
        return NSCalendar.currentCalendar().dateFromComponents(self.dateComponents)
    }
}

extension DayDate: CustomStringConvertible, Hashable, Comparable {
    public var description: String {
        return "\(day).\(month).\(year)"
    }
    
    public var hashValue: Int {
        return year * 10000 + month * 100 + day
    }
}

public func ==(left: DayDate, right: DayDate) -> Bool {
    return left.year == right.year && left.month == right.month && left.day == right.day
}

public func <(left: DayDate, right: DayDate) -> Bool {
    if left.year < right.year {
        return true
    } else if left.year > right.year {
        return false
    }
    
    if left.month < right.month {
        return true
    } else if left.month > right.month {
        return false
    }
    
    return left.day < right.day
}
