//
//  DemoData.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

enum MockData {
    static let arcs: [Arc] = [
        Arc(title: "White Smile Arc", totaldays: 30, dayNumber: 1, subTitle: "", color: .appPurple, icon: "arc", history: (0..<27).map { _ in Int.random(in: 0...100) }, completedArc: 5, tasksForToday: [
            ArcTask(id: UUID(), title: "Habit 1", subtitle: "Small Description", icon: "checkBadge", color: .appPurple, isCompleted: true),
            ArcTask(id: UUID(), title: "Habit 2", subtitle: "Small Description", icon: "checkBadge", color: .appPurple, isCompleted: true),
            ArcTask(id: UUID(), title: "Habit 3", subtitle: "Small Description", icon: "checkBadge", color: .appPurple, isCompleted: false),
            ArcTask(id: UUID(), title: "Habit 4", subtitle: "Small Description", icon: "checkBadge", color: .appPurple, isCompleted: false),
            ArcTask(id: UUID(), title: "Habit 5", subtitle: "Small Description", icon: "checkBadge", color: .appPurple, isCompleted: true),
            ArcTask(id: UUID(), title: "Habit 6", subtitle: "Small Description", icon: "checkBadge", color: .appPurple, isCompleted: false),
            ArcTask(id: UUID(), title: "Habit 7", subtitle: "Small Description", icon: "checkBadge", color: .appPurple, isCompleted: false)
        ]),
        Arc(title: "Gut Health Arc", totaldays: 15, dayNumber: 12, subTitle: "Small Description", color: .appGreen, icon: "arcGreen", history: (0..<12).map { _ in Int.random(in: 0...100) }, completedArc: 8, tasksForToday: [
            ArcTask(id: UUID(), title: "Breath", subtitle: "10 minutes", icon: "checkBadge", color: Color(hex: 0xB56BFF), isCompleted: true),
            ArcTask(id: UUID(), title: "Walk", subtitle: "15 minutes", icon: "checkBadge", color: Color(hex: 0xB56BFF), isCompleted: false)
        ]),
        Arc(title: "Hair Growth Arc", totaldays: 20, dayNumber: 8, subTitle: "Small Description", color: .appOrange, icon: "arcOrange", history: (0..<8).map { _ in Int.random(in: 0...100) }, completedArc: 4, tasksForToday: [
            ArcTask(id: UUID(), title: "Code", subtitle: "Work on app", icon: "checkBadge", color: Color(hex: 0xFFB628), isCompleted: false)
        ]),
    ]

    static let habits: [Habit] = [
        Habit(title: "Meditation", subtitle: "Meditate for at least 30 minutes", color: .appPink, icon: "meditation", completedCount: 0),
        Habit(title: "Side Hustle", subtitle: "Work on my business app", color: .appYellow, icon: "hustle", completedCount: 0),
        Habit(title: "Play Drums", subtitle: "Play drums for at least 30 minutes", color: .appBlue, icon: "drums", completedCount: 0),
    ]
}


