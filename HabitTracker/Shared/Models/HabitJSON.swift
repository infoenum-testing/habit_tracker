//
//  HabitJSON.swift
//  HabitTracker
//
//  Created by IE14 on 04/09/25.
//

import Foundation

// MARK: - Habit Model
struct HabitJSON: Codable {
    let habitId: String
    let title: String
    let description: String
    let icon: String?
    let themeColor: String?
    let points: PointsJSON?
    let tags: [String]?
    let categories: [String]?
    let defaultGoalPerDay: Int?

    enum CodingKeys: String, CodingKey {
        case habitId, title, description, icon, themeColor, points, tags, categories, defaultGoalPerDay
    }
}
