//
//  ItemType.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 16/08/25.
//

import Foundation
import SwiftUI
import CoreData

final class AppDataStore: ObservableObject {
    @Published var layout: HomeLayout = .list
    @Published var selectedDate: Date = Date().stripTime()
    @Published var allHabits: [HabitTemplate] = []
    @Published var allArcs: [ArcTemplate] = []
    @Published var allSubscribedHabits: [SubscribedHabit] = []
    @Published var allSubscribedArcs: [SubscribedArc] = []
    @Published var selectedArctoDelete: SubscribedArc?
    @Published var allHistories: [History] = []
    @Published var selectedHabitToDelete: SubscribedHabit?
    @Published var allStatistics: [Statistics] = []
    @Published var todayStatistics: Statistics?
    @Published var grandTotals: GrandTotals = GrandTotals(
            discipline: 0,
            strength: 0,
            confidence: 0,
            intelligence: 0,
            overall: 0
        )
    @Published var isShowingDeleteArcConfirmation: Bool = false
    @Published var isShowingDeleteHabitConfirmation: Bool = false
    @Published var shownAlerts: Set<String> = []
    @Published  var showToast = false
    @Published  var toastMessage: String = ""
    @Published  var toastType: ToastType = .success

    init() {
        refreshData()
    }
    
    /// Reload everything from CoreData
    func refreshData() {
        refreshHabitsAndArcs()
        refreshSubscribed()
        refreshStatistics()
        refreshHistories()
        
    }

    /// 1. Refresh all habits and arcs
     func refreshHabitsAndArcs() {
        let manager = CoreDataManager.shared
        allHabits = manager.fetchAllHabits()
        allArcs = manager.fetchAllArcs()
    }

    /// 2. Refresh subscribed habits and arcs
     func refreshSubscribed() {
        let manager = CoreDataManager.shared
        allSubscribedHabits = manager.fetchSubscribedHabits()
        allSubscribedArcs = manager.fetchSubscribedArcs()
    }

    /// 3. Refresh statistics
     func refreshStatistics() {
        let manager = CoreDataManager.shared
        todayStatistics = manager.fetchOrCreateTodayStatistics()
        allStatistics = manager.fetchAllStatistics()
        updateGrandTotals()
    }

    /// 4. Refresh histories
     func refreshHistories() {
        let manager = CoreDataManager.shared
        allHistories = manager.fetchAllHistories()
        print("\(allHistories.count)")
    }

    
    func updateGrandTotals() {
            let totals = fetchGrandTotals()
            self.grandTotals = GrandTotals(
                discipline: totals.discipline,
                strength: totals.strength,
                confidence: totals.confidence,
                intelligence: totals.intelligence,
                overall: totals.overall
            )
        }
    
    // MARK: - Actions
    
    func subscribe(to arc: ArcTemplate, completion: ((Result<SubscribedArc, Error>) -> Void)? = nil) {
        let result = CoreDataManager.shared.subscribeArc(to: arc)
        
        switch result {
        case .success(let subscribedArc):
            print("✅ Successfully subscribed to arc: \(subscribedArc.wrappedTitle)")
            refreshSubscribed()
            completion?(.success(subscribedArc))
            
        case .failure(let error):
            print("❌ Failed to subscribe: \(error.localizedDescription)")
            completion?(.failure(error))
            showToast = true
            toastMessage = "\(error.localizedDescription)"
            toastType = .alert
        }
    }
    
    func unsubscribe(arcId: String, completion: @escaping (Bool) -> Void) {
        switch CoreDataManager.shared.unsubscribeArc(withId: arcId) {
        case .success:
            print("✅ Successfully unsubscribed from arc with id: \(arcId)")
            refreshSubscribed()
            completion(true)
        case .failure(let error):
            print("❌ Failed to unsubscribe: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func updateSubscribedArc(arcId: String, icon: String? ,newThemeColor: String?,  completion: @escaping (Bool) -> Void) {
        let result = CoreDataManager.shared.updateSubscribedArc(
            withId: arcId,
            newIcon: icon,
            newThemeColor: newThemeColor
        )
        switch result {
        case .success(let updatedArc):
            print("Updated Arc → \(updatedArc.wrappedIcon), \(updatedArc.wrappedThemeColor)")
            refreshSubscribed()
            completion(true)
        case .failure(let error):
            print("Failed to update arc: \(error)")
            completion(false)
        }
    }
    
    
    
    func completeArc(_ subArc: SubscribedArc) {
        CoreDataManager.shared.completeArc(subArc)
        refreshSubscribed()
    }
    
    func deleteArc(_ subArc: SubscribedArc) {
        CoreDataManager.shared.deleteSubscribedArc(subArc)
        refreshSubscribed()
        refreshHistories()
    }


    func saveHistory(for arc: SubscribedArc, status: ArcStatus) -> History? {
        return CoreDataManager.shared.saveHistory(for: arc, status: status)
        
    }
    
    func fetchSubscribedArcs() -> [SubscribedArc] {
        return CoreDataManager.shared.fetchSubscribedArcs()
    }
}

extension AppDataStore {
    
    func toggleArcHabit(_ habitId: String, in arc: SubscribedArc) {
        CoreDataManager.shared.toggleArcHabit(habitId, in: arc)  { allCompleted, shouldAddPoints, shouldRemovePoints in
            if shouldAddPoints == true {
                if let distributionArray = arc.arcTemplate?.distributionPoints() {
                    for (category, value) in distributionArray {
                        print("\(category) → \(value)")
                        addPoints(category: category, points: Int32(value))
                    }
                }
            }
            if shouldRemovePoints == true {
                if let distributionArray = arc.arcTemplate?.distributionPoints() {
                    for (category, value) in distributionArray {
                        print("\(category) → \(value)")
                        removePoints(category: category, points: Int32(value))
                    }
                }
            }
            if allCompleted {
                print("🎉 All habits completed for today in arc: \(arc.wrappedTitle)")
                handleArcCompletion(for: arc)
            }
            refreshSubscribed()
        }
    }


    private func handleArcCompletion(for arc: SubscribedArc) {
        let today = Calendar.current.startOfDay(for: Date())
        let calendar = Calendar.current
        
        let status: ArcStatus
        
        if calendar.isDate(today, inSameDayAs: arc.wrappedEndDate) {
            status = .completed
        } else if calendar.isDate(today, inSameDayAs: arc.wrappedGraceEndDate) {
            status = .lateCompleted
        } else {
            print("🎉 All habits done for today in arc: \(arc.wrappedTitle)")
            return
        }
        
        if saveHistory(for: arc, status: status) != nil {
            deleteArc(arc)
        }
    }

    func toggleHabit(_ habitId: String, in arc: SubscribedHabit) {
        CoreDataManager.shared.toggleHabit(habitId, in: arc){ isChecked in
            if isChecked {
                print("✅ Habit checked")
                if let distributionArray = arc.habit?.distributionPoints() {
                    for (category, value) in distributionArray {
                        print("\(category) → \(value)")
                        addPoints(category: category, points: Int32(value))
                    }
                }
            } else {
                print("✅ Habit unchecked")
                if let distributionArray = arc.habit?.distributionPoints() {
                    for (category, value) in distributionArray {
                        print("\(category) → \(value)")
                        removePoints(category: category, points: Int32(value))
                    }
                }
            }
            refreshSubscribed()
        }
    }
}


extension AppDataStore {
    
    func subscribeToHabit(to habit: HabitTemplate, completion: ((Result<SubscribedHabit, Error>) -> Void)? = nil) {
        CoreDataManager.shared.subscribeHabit(
            from: habit
        ) { result in
            switch result {
            case .success(let subscribedHabit):
                print("🎉 Subscribed: \(subscribedHabit.wrappedTitle)")
                self.refreshSubscribed()
                completion?(.success(subscribedHabit))
                
            case .failure(let error):
                print("⚠️ Error subscribing: \(error.localizedDescription)")
                completion?(.failure(error))
                self.showToast = true
                self.toastMessage = "\(error.localizedDescription)"
                self.toastType = .alert
                
            }
        }
    }
    
    func unsubscribeHabit(habitID: String, completion: @escaping (Bool) -> Void) {
        CoreDataManager.shared.unsubscribeHabit(
            habitID: habitID
        ) { result in
            switch result {
            case .success:
                print("✅ Successfully unsubscribed")
                self.refreshSubscribed()
                self.refreshHistories()
                completion(true)
            case .failure(let error):
                print("⚠️ Error unsubscribing: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func updateSubscribedHabit(habitID: String, icon: String? ,newThemeColor: String?,  completion: @escaping (Bool) -> Void) {
        let result = CoreDataManager.shared.updateSubscribedHabit(
            withId: habitID,
            newIcon: icon,
            newThemeColor: newThemeColor
        )

        switch result {
        case .success(let updatedHabit):
            self.refreshSubscribed()
            print("Updated Habit → \(updatedHabit.wrappedIcon), \(updatedHabit.wrappedThemeColor)")
            completion(true)
        case .failure(let error):
            print("Failed to update habit: \(error)")
            completion(false)
        }

    }
    
    func deleteHabit(_ subHabit: SubscribedHabit) {
        CoreDataManager.shared.deleteSubscribedHabit(subHabit)
        refreshSubscribed()
    }
}


extension AppDataStore {
    
    func addPoints(category: Statistics.Category , points: Int32) {
        CoreDataManager.shared.addPoints(to: category, points: points)
        refreshStatistics()
    }
    
    func removePoints(category: Statistics.Category, points: Int32) {
        CoreDataManager.shared.removePoints(from: category, points: points)
        refreshStatistics()
    }
    
    func deleteStatistics(_ stats: Statistics) {
        CoreDataManager.shared.deleteStatistics(stats)
        refreshStatistics()
    }
    
    func fetchTotals(for stats: Statistics) -> (discipline: Int32, strength: Int32, confidence: Int32, intelligence: Int32, overall: Int32) {
        return CoreDataManager.shared.totals(for: stats)
    }
    
    func fetchGrandTotals() -> (discipline: Int32, strength: Int32, confidence: Int32, intelligence: Int32, overall: Int32) {
        return CoreDataManager.shared.grandTotals()
    }
}

extension AppDataStore {
    var weeklyDayValues: [DayValue] {
        let stats = CoreDataManager.shared.fetchWeeklyStatistics()
        let calendar = Calendar.current
        let weekStart = Date().startOfWeek
        let today = Date().stripTime()

        return (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: offset, to: weekStart)!
            let dayLabel = date.monthDayStacked

            
            var total: Double = 0
            if date <= today { // ✅ don’t allow future dates
                let dayStat = stats.first { calendar.isDate($0.date ?? Date(), inSameDayAs: date) }
                total = Double(dayStat?.overallTotal ?? 0)
            }

            return DayValue(day: dayLabel, value: total)
        }
    }

    var currentWeekDayLabels: [String] {
        let calendar = Calendar.current
        let weekStart = Date().startOfWeek
        return (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: weekStart)?.monthDayStacked
        }
    }
}
