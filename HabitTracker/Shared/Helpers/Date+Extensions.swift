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
