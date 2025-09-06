//
//  PointsJSON.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 04/09/25.
//


import Foundation

// MARK: - Points
struct PointsJSON: Codable {
    let awardOn: String?
    let rule: [String: String]?
    let distribution: [String: Int]?
}
