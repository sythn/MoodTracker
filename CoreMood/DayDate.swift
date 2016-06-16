//
//  DayDate.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 24/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

protocol DateConvertible {
    init(date: Date)
    var date: Date? { get }
}

protocol DateComponentsConvertible {
    init?(dateComponents: DateComponents)
    var dateComponents: DateComponents { get }
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
        self.init(date: Date())
    }
    
    public init(dateComponents: DateComponents) {
        self.day = dateComponents.day!
        self.month = dateComponents.month!
        self.year = dateComponents.year!
    }
    
    public init(date: Date) {
        let components = Calendar.current().components([.day, .month, .year], from: date)
        self.init(dateComponents: components)
    }
    
    public func dateWithDaysAfter(_ daysAfter: Int) -> DayDate? {
        if let date = self.date,
            let newDate = Calendar.current().date(byAdding: .day, value: daysAfter, to: date, options: []) {
                return DayDate(date: newDate)
        }
        return nil
    }
    
    public var dateComponents: DateComponents {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        return components
    }
    
    public var date: Date? {
        return Calendar.current().date(from: self.dateComponents)
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
