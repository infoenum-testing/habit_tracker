//
//  SubscribedArc+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 28/08/25.
//
//

import Foundation
import CoreData


extension SubscribedArc {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubscribedArc> {
        return NSFetchRequest<SubscribedArc>(entityName: "SubscribedArc")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var graceEndDate: Date?
    @NSManaged public var id: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var themeColor: String?
    @NSManaged public var icon: String?
    @NSManaged public var arcTemplate: ArcTemplate?
    @NSManaged public var subscribedHabits: NSSet?
    @NSManaged public var progressHistory: NSSet?

}

// MARK: Generated accessors for subscribedHabits
extension SubscribedArc {

    @objc(addSubscribedHabitsObject:)
    @NSManaged public func addToSubscribedHabits(_ value: SubscribedHabit)

    @objc(removeSubscribedHabitsObject:)
    @NSManaged public func removeFromSubscribedHabits(_ value: SubscribedHabit)

    @objc(addSubscribedHabits:)
    @NSManaged public func addToSubscribedHabits(_ values: NSSet)

    @objc(removeSubscribedHabits:)
    @NSManaged public func removeFromSubscribedHabits(_ values: NSSet)

}

// MARK: Generated accessors for progressHistory
extension SubscribedArc {

    @objc(addProgressHistoryObject:)
    @NSManaged public func addToProgressHistory(_ value: ArcProgress)

    @objc(removeProgressHistoryObject:)
    @NSManaged public func removeFromProgressHistory(_ value: ArcProgress)

    @objc(addProgressHistory:)
    @NSManaged public func addToProgressHistory(_ values: NSSet)

    @objc(removeProgressHistory:)
    @NSManaged public func removeFromProgressHistory(_ values: NSSet)

}

extension SubscribedArc : Identifiable {

}



extension SubscribedArc {
    
    // MARK: - Wrapped Values
    
    var wrappedId: String {
        id ?? UUID().uuidString
    }
    
    var wrappedThemeColor: String {
        themeColor ?? "blue"
    }
    
    var wrappedIcon: String {
        icon ?? ""
    }
    
    var wrappedStartDate: Date {
        startDate ?? Date()
    }
    
    var wrappedEndDate: Date {
        endDate ?? Date()
    }
    
    var wrappedGraceEndDate: Date {
        graceEndDate ?? Date()
    }
    
    // MARK: - ArcTemplate convenience
    
    var wrappedTitle: String {
        arcTemplate?.title ?? "Arc Title"
    }
    
    var wrappedDurationDays: Int {
        Int(arcTemplate?.durationDays ?? 0)
    }
    
    var wrappedHabitsCount: Int {
        (arcTemplate?.habits as? Set<HabitTemplate>)?.count ?? 0
    }
    
    var wrappedHabits: [HabitTemplate] {
        Array(arcTemplate?.habits as? Set<HabitTemplate> ?? [])
    }
    
    // MARK: - Subscribed Habits
    
    var habitsArray: [SubscribedHabit] {
        let set = subscribedHabits as? Set<SubscribedHabit> ?? []
        return set.sorted { ($0.habit?.title ?? "") < ($1.habit?.title ?? "") }
    }
    
    // MARK: - Progress History
    
    var progressArray: [ArcProgress] {
        let set = progressHistory as? Set<ArcProgress> ?? []
        return set.sorted { ($0.date ?? Date.distantPast) < ($1.date ?? Date.distantPast) }
    }
}

extension SubscribedArc {
    
    /// Day number since start (startDate = Day 1, capped at wrappedDurationDays)
    var currentDayIndex: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: wrappedStartDate)
        let today = calendar.startOfDay(for: Date())
        
        guard let days = calendar.dateComponents([.day], from: start, to: today).day else {
            return 1
        }
        
        let dayIndex = days + 1 // +1 because same day should be Day 1
        return min(max(1, dayIndex), wrappedDurationDays)
    }
    
    /// Days remaining until arc ends (never negative)
    var daysRemaining: Int {
        max(0, wrappedDurationDays - currentDayIndex)
    }
}


// MARK: - Progress Arc Computed Properties
extension SubscribedArc {
    
    func isHabitCompleted(_ habitId: String) -> Bool {
           todayProgress?.completedHabitIds?.contains(habitId) ?? false
        
       }
    
    /// All progress entries sorted by date
    var allProgress: [ArcProgress] {
        guard let progressSet = progressHistory as? Set<ArcProgress> else { return [] }
        return progressSet.sorted { ($0.date ?? Date.distantPast) < ($1.date ?? Date.distantPast) }
    }
    
    /// Progress object for **today**
    var todayProgress: ArcProgress? {
        let today = Calendar.current.startOfDay(for: Date())
        return allProgress.first { progress in
            if let date = progress.date {
                return Calendar.current.isDate(date, inSameDayAs: today)
            }
            return false
        }
    }
    
    /// Total tasks for today
    var totalTasksToday: Int {
        return Int(todayProgress?.totalHabits ?? 0)
    }
    
    /// Completed tasks for today
    var completedTasksToday: Int {
        return Int(todayProgress?.completedHabitIds?.count ?? 0)
    }
    
    /// Progress ratio (0–1) for today
    var todayCompletionRatio: Double {
        guard totalTasksToday > 0 else { return 0 }
        return Double(completedTasksToday) / Double(totalTasksToday)
    }
}


extension SubscribedArc {
    /// Returns 40 opacity values (latest 40 days).
    var last100DayOpacities: [Double] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Build last 40 dates (most recent first, then reversed to oldest → newest)
        let last100Dates = (0..<100).compactMap {
            calendar.date(byAdding: .day, value: -$0, to: today)
        }.reversed()
        
        return last100Dates.map { date in
            // Find ArcProgress entry for that date
            if let progress = progressArray.first(where: {
                if let pDate = $0.date {
                    return calendar.isDate(pDate, inSameDayAs: date)
                }
                return false
            }) {
                let total = Double(progress.totalHabits)
                let completed = Double(progress.completedHabits)
                guard total > 0 else { return 0.3 }
                
                let ratio = completed / total
                return ratio == 0 ? 0.3 : 0.3 + (ratio * 0.7)
            } else {
                // No entry for this date → baseline opacity
                return 0.3
            }
        }
    }
}


//extension SubscribedArc {
//    
//    /// Daily progress from arc start → today
//    var dailyProgressOpacities: [Double] {
//        let calendar = Calendar.current
//        let start = calendar.startOfDay(for: wrappedStartDate)
//        let end = calendar.startOfDay(for: Date())
//        
//        // Generate all dates from start → today
//        guard let days = calendar.dateComponents([.day], from: start, to: end).day else {
//            return []
//        }
//        
//        let allDates = (0...days).compactMap {
//            calendar.date(byAdding: .day, value: $0, to: start)
//        }
//        
//        return allDates.map { date in
//            // Find progress for this date
//            if let progress = progressArray.first(where: {
//                if let pDate = $0.date {
//                    return calendar.isDate(pDate, inSameDayAs: date)
//                }
//                return false
//            }) {
//                let total = Double(progress.totalHabits)
//                let completed = Double(progress.completedHabits)
//                guard total > 0 else { return (0.0) }
//                
//                let ratio = completed / total
//                return (ratio == 0 ? 0.0 : 0.3 + (ratio * 0.7))
//            } else {
//                // No data for this date → 0.0
//                return (0.0)
//            }
//        }
//    }
//}


extension SubscribedArc {
    
    /// Daily progress from arc start → today (max 100 days)
    var dailyProgressOpacities: [Double] {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: wrappedStartDate)
        let end = calendar.startOfDay(for: Date())
        
        // Total days passed since start
        guard let daysPassed = calendar.dateComponents([.day], from: start, to: end).day else {
            return []
        }
        
        // Cap to 100 days
        let cappedDays = min(daysPassed, 99) // 0...99 → 100 entries max
        
        let allDates = (0...cappedDays).compactMap {
            calendar.date(byAdding: .day, value: $0, to: start)
        }
        
        return allDates.map { date in
            // Find progress for this date
            if let progress = progressArray.first(where: {
                if let pDate = $0.date {
                    return calendar.isDate(pDate, inSameDayAs: date)
                }
                return false
            }) {
                let total = Double(progress.totalHabits)
                let completed = Double(progress.completedHabits)
                guard total > 0 else { return (0.3) }
                
                let ratio = completed / total
                return (ratio == 0 ? 0.3 : 0.3 + (ratio * 0.7))
            } else {
                // No data for this date → 0.0
                return (0.3)
            }
        }
    }
}
