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


