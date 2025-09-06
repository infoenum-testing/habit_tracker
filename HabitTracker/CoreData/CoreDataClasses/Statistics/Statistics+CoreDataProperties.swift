//
//  Statistics+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 26/08/25.
//
//

import Foundation
import CoreData


extension Statistics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Statistics> {
        return NSFetchRequest<Statistics>(entityName: "Statistics")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var disciplineTotal: Int32
    @NSManaged public var strengthTotal: Int32
    @NSManaged public var confidenceTotal: Int32
    @NSManaged public var intelligenceTotal: Int32
    @NSManaged public var overallTotal: Int32
    @NSManaged public var disciplineDelta: Int32
    @NSManaged public var strengthDelta: Int32
    @NSManaged public var confidenceDelta: Int32
    @NSManaged public var intelligenceDelta: Int32
    @NSManaged public var overallDelta: Int32

}

extension Statistics : Identifiable {

}


extension Statistics {
    
    enum Category {
        case discipline
        case strength
        case confidence
        case intelligence
        
        init?(from string: String) {
            switch string.lowercased() {
            case "Discipline": self = .discipline
            case "Strength": self = .strength
            case "Confidence": self = .confidence
            case "Intelligence": self = .intelligence
            default: return nil
            }
        }
        
        static func random() -> Category {
            let categories: [Category] = [.discipline, .strength, .confidence, .intelligence]
            return categories.randomElement()!
        }
    }

    
    
    
    /// Add points to a specific category
    func addPoints(to category: Category, points: Int32 = 1) {
        switch category {
        case .discipline:
            disciplineTotal += points
            disciplineDelta += points
        case .strength:
            strengthTotal += points
            strengthDelta += points
        case .confidence:
            confidenceTotal += points
            confidenceDelta += points
        case .intelligence:
            intelligenceTotal += points
            intelligenceDelta += points
        }
        overallTotal += points
        overallDelta += points
    }
    
    /// Remove points if habit unchecked
    func removePoints(from category: Category, points: Int32 = 1) {
        switch category {
        case .discipline:
            disciplineTotal = max(0, disciplineTotal - points)
            disciplineDelta = max(0, disciplineDelta - points)
        case .strength:
            strengthTotal = max(0, strengthTotal - points)
            strengthDelta = max(0, strengthDelta - points)
        case .confidence:
            confidenceTotal = max(0, confidenceTotal - points)
            confidenceDelta = max(0, confidenceDelta - points)
        case .intelligence:
            intelligenceTotal = max(0, intelligenceTotal - points)
            intelligenceDelta = max(0, intelligenceDelta - points)
        }
        overallTotal = max(0, overallTotal - points)
        overallDelta = max(0, overallDelta - points)
    }
}
