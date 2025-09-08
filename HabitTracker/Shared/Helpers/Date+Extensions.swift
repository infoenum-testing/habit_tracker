//
//  Date+Extensions.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

extension Date {
    func stripTime() -> Date {
        let cal = Calendar.current
        return cal.startOfDay(for: self)
    }
    func weekdayShort() -> String { let f = DateFormatter(); f.dateFormat = "EEE"; return f.string(from: self).uppercased() }
    func dayString() -> String { let f = DateFormatter(); f.dateFormat = "d"; return f.string(from: self) }
    func sevenDayWindow() -> [Date] {
        // Fixed 7-day bar around the selected date, cannot be moved by user; this keeps selection centered when possible
        let cal = Calendar.current
        let base = self
        return (-2...4).map { cal.date(byAdding: .day, value: $0, to: base)! }.map { $0.stripTime() }
    }
    func fiveDayWindow() -> [Date] {
        let cal = Calendar.current
        let base = self.stripTime()
        return (-2...2)
            .compactMap { cal.date(byAdding: .day, value: $0, to: base) }
            .map { $0.stripTime() }
    }
}

extension Date {
    func toReadableString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: self)
    }
}

extension Date {
    var startOfWeek: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
}

extension Date {
    var shortWeekday: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Mon, Tue, Wed, ...
        return formatter.string(from: self)
    }
}

extension Date {
    var monthDayStacked: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d" // "Jan 12"
        let formatted = formatter.string(from: self)
        
        // Split into "Jan" and "12"
        let parts = formatted.split(separator: " ")
        if parts.count == 2 {
            return "\(parts[0])\n\(parts[1])" // "Jan\n12"
        }
        return formatted
    }
}

extension Date {
    var fullWeekday: String {
        let f = DateFormatter()
        f.dateFormat = "EEEE" // Saturday
        return f.string(from: self)
    }
    
    var monthDayYear: String {
           let f = DateFormatter()
           f.dateFormat = "MMMM d, yyyy" // August 9, 2025
           return f.string(from: self)
       }
}
