//
//  SubscribedHabit+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 28/08/25.
//
//

import Foundation
import CoreData


extension SubscribedHabit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubscribedHabit> {
        return NSFetchRequest<SubscribedHabit>(entityName: "SubscribedHabit")
    }

    @NSManaged public var id: String?
    @NSManaged public var requiredPerDay: Int16
    @NSManaged public var icon: String?
    @NSManaged public var themeColor: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var habit: HabitTemplate?
    @NSManaged public var subscribedArc: SubscribedArc?
    @NSManaged public var progressHistory: NSSet?

}

// MARK: Generated accessors for progressHistory
extension SubscribedHabit {

    @objc(addProgressHistoryObject:)
    @NSManaged public func addToProgressHistory(_ value: HabitProgress)

    @objc(removeProgressHistoryObject:)
    @NSManaged public func removeFromProgressHistory(_ value: HabitProgress)

    @objc(addProgressHistory:)
    @NSManaged public func addToProgressHistory(_ values: NSSet)

    @objc(removeProgressHistory:)
    @NSManaged public func removeFromProgressHistory(_ values: NSSet)

}

extension SubscribedHabit : Identifiable {

}


extension SubscribedHabit {
    
    // MARK: - Basic properties
    var wrappedId: String {
        id ?? ""
    }
    
    var wrappedRequiredPerDay: Int {
        Int(requiredPerDay)
    }
    
    var wrappedIcon: String {
        icon ?? habit?.icon ?? "star"
    }
    
    var wrappedThemeColor: String {
        themeColor ?? "blue"
    }
    
    var wrappedStartDate: Date {
        startDate ?? Date()
    }
    
    // MARK: - HabitTemplate properties (fallback)
    var wrappedTitle: String {
        habit?.title ?? "Untitled Habit"
    }
    
    var wrappedCategory: String {
        habit?.category ?? "General"
    }
    
    var wrappedDetails: String {
        habit?.details ?? "No details available"
    }
    
    var wrappedTags: [String] {
        habit?.tagsArray ?? []
    }
    
    var wrappedPointsPerDay: [String: Any] {
        habit?.pointsPerDay as! [String : Any]
    }
    
    // MARK: - Relationships
    var wrappedSubscribedArc: SubscribedArc? {
        subscribedArc
    }
    
    var wrappedProgressHistory: [HabitProgress] {
        let set = progressHistory as? Set<HabitProgress> ?? []
        return set.sorted { $0.date ?? Date() < $1.date ?? Date() }
    }
}


extension SubscribedHabit {
    
    func isHabitCompleted(_ habitId: String) -> Bool {
           todayProgress?.completedHabitIds?.contains(habitId) ?? false
       }
    
    /// All progress entries sorted by date
    var allProgress: [HabitProgress] {
        guard let progressSet = progressHistory as? Set<HabitProgress> else { return [] }
        return progressSet.sorted { ($0.date ?? Date.distantPast) < ($1.date ?? Date.distantPast) }
    }
    
    /// Progress object for **today**
    var todayProgress: HabitProgress? {
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


extension SubscribedHabit {
    
    /// Returns 100 days of completion flags (oldest → newest).
    var last100DayCompletion: [Bool] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Build last 100 dates (oldest → newest)
        let last100Dates = (0..<100).compactMap {
            calendar.date(byAdding: .day, value: -$0, to: today)
        }.reversed()
        
        return last100Dates.map { date in
            // Find HabitProgress entry for this date
            if let progress = wrappedProgressHistory.first(where: {
                if let pDate = $0.date {
                    return calendar.isDate(pDate, inSameDayAs: date)
                }
                return false
            }) {
                // Mark as completed if requiredPerDay is satisfied
                return progress.completedCount >= requiredPerDay
            } else {
                // No entry → not completed
                return false
            }
        }
    }
    
    /// Returns 100 days of completion ratios (0–1, useful for charts).
    var last100DayRatios: [Double] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let last100Dates = (0..<100).compactMap {
            calendar.date(byAdding: .day, value: -$0, to: today)
        }.reversed()
        
        return last100Dates.map { date in
            if let progress = wrappedProgressHistory.first(where: {
                if let pDate = $0.date {
                    return calendar.isDate(pDate, inSameDayAs: date)
                }
                return false
            }) {
                let total = Double(requiredPerDay)
                let completed = Double(progress.completedCount)
                guard total > 0 else { return 0 }
                return min(1.0, completed / total)
            } else {
                return 0
            }
        }
    }
}

extension SubscribedHabit {
    
    /// Returns 100 days of opacities (0.3 for incomplete, 1.0 for completed)
    var last100DayOpacities: [Double] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let last100Dates = (0..<100).compactMap {
            calendar.date(byAdding: .day, value: -$0, to: today)
        }.reversed()
        
        return last100Dates.map { date in
            if let progress = wrappedProgressHistory.first(where: {
                if let pDate = $0.date {
                    return calendar.isDate(pDate, inSameDayAs: date)
                }
                return false
            }) {
                // ✅ completed if progress meets or exceeds requiredPerDay
                return progress.completedCount >= requiredPerDay ? 1.0 : 0.3
            } else {
                return 0.3
            }
        }
    }
}


extension SubscribedHabit {
    
    /// Returns daily opacities from startDate → today (max 100 days).
    var dailyOpacities: [Double] {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: wrappedStartDate) // you might need to add `wrappedStartDate` like you did for arc
        let end = calendar.startOfDay(for: Date())
        
        // How many days since start
        guard let daysPassed = calendar.dateComponents([.day], from: start, to: end).day else {
            return []
        }
        
        // Cap to 100 days (remove min(...) if you want full range)
        let cappedDays = min(daysPassed, 99)
        
        let allDates = (0...cappedDays).compactMap {
            calendar.date(byAdding: .day, value: $0, to: start)
        }
        
        return allDates.map { date in
            if let progress = wrappedProgressHistory.first(where: {
                if let pDate = $0.date {
                    return calendar.isDate(pDate, inSameDayAs: date)
                }
                return false
            }) {
                return progress.completedCount >= requiredPerDay ? 1.0 : 0.3
            } else {
                return 0.3
            }
        }
    }
}
