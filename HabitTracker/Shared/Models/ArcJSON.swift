//
//  ArcJSON.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 04/09/25.
//

import Foundation


// MARK: - Arc Model
struct ArcJSON: Codable {
    let arcId: String
    let title: String
    let shortSubtitle: String?
    let description: String?
    let durationDays: Int
    let themeColor: String?
    let coverImage: String?
    let benefits: [String]?
    let habits: [HabitReferenceJSON]?
    let tags: [String]?
    let points: PointsJSON?
    let categories: [String]?
    let metaCreatedAt: String?
    let metaUpdatedAt: String?
    let icons: [String: String]?
    var createdBy: String? = "Arcetype Staff"
}
