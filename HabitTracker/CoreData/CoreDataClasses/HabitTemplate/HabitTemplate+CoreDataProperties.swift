//
//  HabitTemplate+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 26/08/25.
//
//

import Foundation
import CoreData


extension HabitTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HabitTemplate> {
        return NSFetchRequest<HabitTemplate>(entityName: "HabitTemplate")
    }

    @NSManaged public var category: [String]?
    @NSManaged public var colorToken: String?
    @NSManaged public var defaultGoalPerDay: Int16
    @NSManaged public var details: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var pointsPerDay: [String: Any]?
    @NSManaged public var tags: NSObject?
    @NSManaged public var title: String?
    @NSManaged public var arcTemplates: NSSet?
    @NSManaged public var subscribedHabits: NSSet?

}

// MARK: Generated accessors for arcTemplates
extension HabitTemplate {

    @objc(addArcTemplatesObject:)
    @NSManaged public func addToArcTemplates(_ value: ArcTemplate)

    @objc(removeArcTemplatesObject:)
    @NSManaged public func removeFromArcTemplates(_ value: ArcTemplate)

    @objc(addArcTemplates:)
    @NSManaged public func addToArcTemplates(_ values: NSSet)

    @objc(removeArcTemplates:)
    @NSManaged public func removeFromArcTemplates(_ values: NSSet)

}

// MARK: Generated accessors for subscribedHabits
extension HabitTemplate {

    @objc(addSubscribedHabitsObject:)
    @NSManaged public func addToSubscribedHabits(_ value: SubscribedHabit)

    @objc(removeSubscribedHabitsObject:)
    @NSManaged public func removeFromSubscribedHabits(_ value: SubscribedHabit)

    @objc(addSubscribedHabits:)
    @NSManaged public func addToSubscribedHabits(_ values: NSSet)

    @objc(removeSubscribedHabits:)
    @NSManaged public func removeFromSubscribedHabits(_ values: NSSet)

}

extension HabitTemplate : Identifiable {

}


extension HabitTemplate {
    var tagsArray: [String] {
        tags as? [String] ?? []
    }
    var categoresArray: [String] {
        category ?? []
    }
}

extension HabitTemplate {
    
    // MARK: - Wrapped properties
    
    var wrappedId: String {
        id ?? UUID().uuidString
    }
    
    var wrappedTitle: String {
        title ?? "Untitled"
    }
    
    var wrappedCategory: [String] {
        category ?? ["General"]
    }
    
    var wrappedColorToken: String {
        colorToken ?? "white"
    }
    
    var wrappedDetails: String {
        details ?? ""
    }
    
    var wrappedIcon: String {
        icon ?? "icon.default"
    }
    
    var wrappedPointsPerDay: [String: Int] {
        pointsPerDay as? [String: Int] ?? [:]
    }
    
    var wrappedTags: [String] {
        tags as? [String] ?? []
    }
    
    var subscribedHabitsArray: [SubscribedHabit] {
        (subscribedHabits as? Set<SubscribedHabit>)?.sorted { $0.wrappedId < $1.wrappedId } ?? []
    }
}


extension HabitTemplate {
    var points: PointsPerDay? {
        get {
            guard let raw = pointsPerDay else { return nil }
            do {
                let data = try JSONSerialization.data(withJSONObject: raw)
                return try JSONDecoder().decode(PointsPerDay.self, from: data)
            } catch {
                print("❌ Failed to decode HabitTemplate PointsPerDay:", error)
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
                print("❌ Failed to encode HabitTemplate PointsPerDay:", error)
            }
        }
    }
}

extension HabitTemplate {
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


import CoreData

extension HabitTemplate {
    convenience init(from model: HabitJSON, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = model.habitId
        self.title = model.title
        self.details = model.description
        self.icon = model.icon
        self.colorToken = model.themeColor
        self.category = model.categories
        self.defaultGoalPerDay = Int16(model.defaultGoalPerDay ?? 1)
        self.tags = model.tags as NSObject?
        if let points = model.points {
            self.pointsPerDay = [
                "awardOn": points.awardOn ?? "",
                "distribution": points.distribution ?? [:]
            ]
        }
    }
}

