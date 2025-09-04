//
//  ArcTemplate+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 26/08/25.
//
//

import Foundation
import CoreData


extension ArcTemplate {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArcTemplate> {
        return NSFetchRequest<ArcTemplate>(entityName: "ArcTemplate")
    }
    
    @NSManaged public var benefits: [String]?
    @NSManaged public var category: [String]?
    @NSManaged public var colorToken: String?
    @NSManaged public var coverImage: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var durationDays: Int16

    @NSManaged public var icons: [String: String]?
    @NSManaged public var id: String?
    @NSManaged public var metaAuthor: String?
    @NSManaged public var metaCreatedAt: Date?
    @NSManaged public var metaUpdatedAt: Date?
    @NSManaged public var pointsPerDay: [String: Any]?
    @NSManaged public var shortSubtitle: String?
    @NSManaged public var tags: [String]?
    @NSManaged public var title: String?
    @NSManaged public var habitsData: [[String: Any]]?
    @NSManaged public var subscribedArcs: NSSet?
    
}


// MARK: Generated accessors for subscribedArcs
extension ArcTemplate {
    
    @objc(addSubscribedArcsObject:)
    @NSManaged public func addToSubscribedArcs(_ value: SubscribedArc)
    
    @objc(removeSubscribedArcsObject:)
    @NSManaged public func removeFromSubscribedArcs(_ value: SubscribedArc)
    
    @objc(addSubscribedArcs:)
    @NSManaged public func addToSubscribedArcs(_ values: NSSet)
    
    @objc(removeSubscribedArcs:)
    @NSManaged public func removeFromSubscribedArcs(_ values: NSSet)
    
}

extension ArcTemplate : Identifiable {
    
}

extension ArcTemplate {
    var tagsArray: [String] {
        tags ?? []
    }
    var categoriesArray: [String] {
        category ?? []
    }
}



struct ArcIcons: Codable {
    var days: String
    var habits: String
}


extension ArcTemplate {
    /// Computed property to get habits as [HabitData]
    var habitList: [HabitData] {
        get {
            guard let raw = habitsData else { return [] }
            do {
                let data = try JSONSerialization.data(withJSONObject: raw)
                return try JSONDecoder().decode([HabitData].self, from: data)
            } catch {
                print("❌ Failed to decode HabitData:", error)
                return []
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                let jsonObject = try JSONSerialization.jsonObject(with: data)
                habitsData = jsonObject as? [[String: Any]]
            } catch {
                print("❌ Failed to encode HabitData:", error)
            }
        }
    }
}


extension ArcTemplate {
    var points: PointsPerDay? {
        get {
            guard let raw = pointsPerDay else { return nil }
            do {
                let data = try JSONSerialization.data(withJSONObject: raw)
                return try JSONDecoder().decode(PointsPerDay.self, from: data)
            } catch {
                print("❌ Failed to decode PointsPerDay:", error)
                return nil
            }
        }
        set {
            guard let newValue = newValue else {
                pointsPerDay = nil
                return
            }
            do {
                let data = try JSONEncoder().encode(newValue)
                let jsonObject = try JSONSerialization.jsonObject(with: data)
                pointsPerDay = jsonObject as? [String: Any]
            } catch {
                print("❌ Failed to encode PointsPerDay:", error)
            }
        }
    }
}

extension ArcTemplate {
    /// Returns distribution as an array of (Statistics.Category, Int) where value > 0
    func distributionPoints() -> [(Statistics.Category, Int)] {
        guard let points = self.points else { return [] }
        
        let dist = points.distribution
        let allPoints: [(Statistics.Category, Int)] = [
            (.discipline, dist.discipline),
            (.strength, dist.strength),
            (.confidence, dist.confidence),
            (.intelligence, dist.intelligence)
        ]
        
        return allPoints.filter { $0.1 > 0 }
    }
}




struct PointsPerDay: Codable {
    let awardOn: String
    let rule: Rule?
    let distribution: Distribution
}

struct Rule: Codable {
    let type: String
}

struct Distribution: Codable {
    let discipline: Int
    let strength: Int
    let confidence: Int
    let intelligence: Int
}

struct HabitData: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
}
