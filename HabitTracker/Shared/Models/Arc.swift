//
//  ItemType.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 16/08/25.
//

import Foundation
import SwiftUI

struct Arc: Identifiable, Hashable {
    let id: UUID
    var title: String
    var dayNumber: Int
    var subTitle: String
    var color: Color
    var icon: String
    var history: [Int]
    var completedArc: Int
    var tasksForToday: [ArcTask]

    init(id: UUID = UUID(), title: String, dayNumber: Int, subTitle: String, color: Color, icon: String, history: [Int],completedArc: Int, tasksForToday: [ArcTask]) {
        self.id = id
        self.title = title
        self.dayNumber = dayNumber
        self.subTitle = subTitle
        self.color = color
        self.icon = icon
        self.history = history
        self.completedArc = completedArc
        self.tasksForToday = tasksForToday
    }

    var completedCount: Int { tasksForToday.filter { $0.isCompleted }.count }
    var totalCount: Int { max(tasksForToday.count, 1) }
    var progress: Double { Double(completedCount) / Double(totalCount) }
}

