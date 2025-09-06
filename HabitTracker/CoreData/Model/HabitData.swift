//
//  HabitData.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import Foundation

// MARK: - Habit Data Model
struct HabitData: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
}
