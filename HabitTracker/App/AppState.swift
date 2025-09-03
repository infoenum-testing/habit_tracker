//
//  ItemType.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 16/08/25.
//

import Foundation
import SwiftUI

//final class AppState: ObservableObject {
//    @Published var selectedDate: Date = Date().stripTime()
//    @Published var layout: HomeLayout = .list
//    @Published var arcs: [Arc]
//    @Published var habits: [Habit]
//    
//    init(arcs: [Arc], habits: [Habit]) {
//        self.arcs = arcs
//        self.habits = habits
//    }
//    
//    enum ListItem: Identifiable {
//        case arc(Arc)
//        case habit(Habit)
//        
//        var id: String {
//            switch self {
//            case .arc(let arc): return arc.id.uuidString   // ✅ convert UUID → String
//            case .habit(let habit): return habit.id.uuidString        // already String
//            }
//        }
//    }
//    
//    
//    var allItems: [ListItem] {
//        let arcItems = arcs.map { ListItem.arc($0) }
//        let habitItems = habits.map { ListItem.habit($0) }
//        return arcItems + habitItems
//    }
//    
//    func toggleHabit(_ habit: Habit) {
////        let day = selectedDate.stripTime()
////        guard let idx = habits.firstIndex(where: { $0.id == habit.id }) else { return }
////        if habits[idx].completions.contains(day) {
////            habits[idx].completions.remove(day)
////        } else {
////            habits[idx].completions.insert(day)
////        }
//    }
//    
//    func toggleHabitAndUpdateCount(_ habit: Habit) {
////        let day = selectedDate.stripTime()
////        guard let idx = habits.firstIndex(where: { $0.id == habit.id }) else { return }
////        if habits[idx].completions.contains(day) {
////            // was done → now unchecked
////            habits[idx].completedCount += 1
////        } else {
////            // was not done → now checked
////            habits[idx].completedCount -= 1
////        }
//    }
//    
//    
//    func toggleArcTask(_ taskID: UUID, in arcID: UUID) {
//        guard let arcIndex = arcs.firstIndex(where: { $0.id == arcID }) else { return }
//        if let tIndex = arcs[arcIndex].tasksForToday.firstIndex(where: { $0.id == taskID }) {
//            var arc = arcs[arcIndex]
//            arc.tasksForToday[tIndex].isCompleted.toggle()
//            arc.history[arc.dayNumber-1] = Int(arc.progress * 100)
//            arcs[arcIndex] = arc
//        }
//    }
//    
//    var activeArcs: [Arc] { arcs.filter { _ in true } }
//}


struct GrandTotals {
    var discipline: Int32
    var strength: Int32
    var confidence: Int32
    var intelligence: Int32
    var overall: Int32
}


import Foundation
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
    
    @Published  var showToast = false
    @Published  var toastMessage: String = ""
    @Published  var toastType: ToastType = .success

    init() {
        refreshData()
    }
    
    /// Reload everything from CoreData
    func refreshData() {
        let manager = CoreDataManager.shared
        allHabits = manager.fetchAllHabits()
        allArcs = manager.fetchAllArcs()
        allSubscribedHabits = manager.fetchSubscribedHabits()
        allSubscribedArcs = manager.fetchSubscribedArcs()
        allHistories = manager.fetchAllHistories()
        todayStatistics = manager.fetchOrCreateTodayStatistics()
        allStatistics = manager.fetchAllStatistics()
        updateGrandTotals()
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
            refreshData()
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
            refreshData()
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
            refreshData()
            completion(true)
        case .failure(let error):
            print("Failed to update arc: \(error)")
            completion(false)
        }
    }
    
    
    
    func completeArc(_ subArc: SubscribedArc) {
        CoreDataManager.shared.completeArc(subArc)
        refreshData()
    }
    
    func deleteArc(_ subArc: SubscribedArc) {
        CoreDataManager.shared.deleteSubscribedArc(subArc)
        refreshData()
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
        CoreDataManager.shared.toggleArcHabit(habitId, in: arc){ isChecked in
            if isChecked {
                print("✅ Habit checked")
                addPoints()
            } else {
                print("❌ Habit unchecked")
                removePoints()
            }
            refreshData()
        }
        
    }

    private func handleArcCompletion(for arc: SubscribedArc) {
        let today = Calendar.current.startOfDay(for: Date())
        guard Calendar.current.isDate(today, inSameDayAs: arc.wrappedEndDate) else {
            print("🎉 All habits done for today in arc: \(arc.wrappedTitle)")
            return
        }
        if saveHistory(for: arc, status: .completed) != nil {
            deleteArc(arc)
        }
    }

    func toggleHabit(_ habitId: String, in arc: SubscribedHabit) {
        CoreDataManager.shared.toggleHabit(habitId, in: arc){ isChecked in
            if isChecked {
                print("✅ Habit checked")
                addPoints()
            } else {
                print("❌ Habit unchecked")
                removePoints()
            }
            refreshData()
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
                self.refreshData()
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
                self.refreshData()
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
            self.refreshData()
            print("Updated Habit → \(updatedHabit.wrappedIcon), \(updatedHabit.wrappedThemeColor)")
            completion(true)
        case .failure(let error):
            print("Failed to update habit: \(error)")
            completion(false)
        }

    }
    
    func deleteHabit(_ subHabit: SubscribedHabit) {
        CoreDataManager.shared.deleteSubscribedHabit(subHabit)
        refreshData()
    }
}


extension AppDataStore {
    
    func addPoints(category: Statistics.Category = Statistics.Category.random(), points: Int32 = 1) {
        CoreDataManager.shared.addPoints(to: category, points: points)
        refreshData()
    }
    
    func removePoints(category: Statistics.Category = Statistics.Category.random(), points: Int32 = 1) {
        CoreDataManager.shared.removePoints(from: category, points: points)
        refreshData()
    }
    
    func deleteStatistics(_ stats: Statistics) {
        CoreDataManager.shared.deleteStatistics(stats)
        refreshData()
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
            let dayLabel = date.shortWeekday  // ✅ dynamic Mon, Tue, ...
            
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
            calendar.date(byAdding: .day, value: $0, to: weekStart)?.shortWeekday
        }
    }
}
