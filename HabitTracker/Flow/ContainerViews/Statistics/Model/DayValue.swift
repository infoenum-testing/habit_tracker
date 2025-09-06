//
//  DayValue.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import SwiftUI

// MARK: - Model
struct DayValue: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}
