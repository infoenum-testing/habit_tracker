//
//  ItemType.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 16/08/25.
//

import Foundation
import SwiftUI

final class AppState: ObservableObject {
    @Published var selectedDate: Date = Date().stripTime()
    @Published var layout: HomeLayout = .list
    @Published var arcs: [Arc]
    @Published var habits: [Habit]
    
    init(arcs: [Arc], habits: [Habit]) {
        self.arcs = arcs
        self.habits = habits
    }
    
    enum ListItem: Identifiable {
        case arc(Arc)
        case habit(Habit)
        
        var id: String {
            switch self {
            case .arc(let arc): return arc.id.uuidString   // ✅ convert UUID → String
            case .habit(let habit): return habit.id.uuidString        // already String
            }
        }
    }
    
    
    var allItems: [ListItem] {
        let arcItems = arcs.map { ListItem.arc($0) }
        let habitItems = habits.map { ListItem.habit($0) }
        return arcItems + habitItems
    }
    
    func toggleHabit(_ habit: Habit) {
        let day = selectedDate.stripTime()
        guard let idx = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        if habits[idx].completions.contains(day) {
            habits[idx].completions.remove(day)
        } else {
            habits[idx].completions.insert(day)
        }
    }
    
    func toggleHabitAndUpdateCount(_ habit: Habit) {
        let day = selectedDate.stripTime()
        guard let idx = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        if habits[idx].completions.contains(day) {
            // was done → now unchecked
            habits[idx].completedCount += 1
        } else {
            // was not done → now checked
            habits[idx].completedCount -= 1
        }
    }
    
    
    func toggleArcTask(_ taskID: UUID, in arcID: UUID) {
        guard let arcIndex = arcs.firstIndex(where: { $0.id == arcID }) else { return }
        if let tIndex = arcs[arcIndex].tasksForToday.firstIndex(where: { $0.id == taskID }) {
            var arc = arcs[arcIndex]
            arc.tasksForToday[tIndex].isCompleted.toggle()
            arc.history[arc.dayNumber-1] = Int(arc.progress * 100)
            arcs[arcIndex] = arc
        }
    }
    
    var activeArcs: [Arc] { arcs.filter { _ in true } }
}


import Foundation
import CoreData

final class AppDataStore: ObservableObject {
    //static let shared = AppDataStore()
    
    @Published var allHabits: [HabitTemplate] = []
    @Published var allArcs: [ArcTemplate] = []
    @Published var subscribedArcs: [SubscribedArc] = []
    @Published var allSubscribedHabits: [SubscribedHabit] = []
    @Published var allSubscribedArcs: [SubscribedArc] = []
    @Published var selectedArctoDelete: SubscribedArc?
    @Published var allHistories: [History] = []
    @Published var selectedHabitToDelete: SubscribedHabit?
    @Published var isShowingDeleteArcConfirmation: Bool = false
    @Published var isShowingDeleteHabitConfirmation: Bool = false
    
    
    
    init() {
        
        refreshData()
    }
    
    /// Reload everything from CoreData
    func refreshData() {
        let manager = CoreDataManager.shared
        allHabits = manager.fetchAllHabits()
        allArcs = manager.fetchAllArcs()
        subscribedArcs = manager.fetchSubscribedArcs()
        allSubscribedHabits = manager.fetchSubscribedHabits()
        allSubscribedArcs = manager.fetchSubscribedArcs()
        allHistories = manager.fetchAllHistories()
        print("\(allHistories.count)")
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
    
    
    
    func completeArc(_ subArc: SubscribedArc) {
        CoreDataManager.shared.completeArc(subArc)
        refreshData()
    }
    
    func deleteArc(_ subArc: SubscribedArc) {
        CoreDataManager.shared.deleteSubscribedArc(subArc)
        refreshData()
    }
    
    func fetchSubscribedArcs() -> [SubscribedArc] {
        return CoreDataManager.shared.fetchSubscribedArcs()
    }
}


extension AppDataStore {
    func toggleHabit(_ habitId: String, in arc: SubscribedArc) {
        CoreDataManager.shared.toggleHabit(habitId, in: arc)
        refreshData()
    }
    func toggleHabit(_ habitId: String, in arc: SubscribedHabit) {
        CoreDataManager.shared.toggleHabit(habitId, in: arc)
        refreshData()
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
    
    func deleteHabit(_ subHabit: SubscribedHabit) {
        CoreDataManager.shared.deleteSubscribedHabit(subHabit)
        refreshData()
    }
}
