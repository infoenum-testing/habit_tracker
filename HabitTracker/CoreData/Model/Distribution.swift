//
//  Distribution.swift
//  HabitTracker
//
// Created by Mayur Shrivas on 06/09/25.
//

import Foundation

// MARK: - Distribution Model
struct Distribution: Codable {
    let discipline: Int
    let strength: Int
    let confidence: Int
    let intelligence: Int
}
