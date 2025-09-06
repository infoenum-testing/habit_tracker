//
//  PointsPerDay.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import Foundation

struct PointsPerDay: Codable {
    let awardOn: String
    let rule: Rule?
    let distribution: Distribution
}
