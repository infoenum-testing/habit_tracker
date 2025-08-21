//
//  ItemType.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 16/08/25.
//

import Foundation
import SwiftUI

struct Habit: Identifiable, Hashable {
    let id: UUID
    var title: String
    var subtitle: String
    var color: Color
    var icon: String
    var completedCount: Int
    // completion by date (midnight components)
    var completions: Set<Date> = []

    init(id: UUID = UUID(), title: String, subtitle: String, color: Color, icon: String,completedCount: Int, completions: Set<Date> = []) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.color = color
        self.icon = icon
        self.completedCount = completedCount
        self.completions = completions
    }

    func isDone(on date: Date) -> Bool { completions.contains(date.stripTime()) }
}


