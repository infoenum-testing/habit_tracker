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
    @NSManaged public var category: String?
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
    
//    var habitsArray: [HabitTemplate] {
//        Array(habits as? Set<HabitTemplate> ?? [])
//    }
}



struct ArcIcons: Codable {
    var days: String
    var habits: String
}


extension ArcTemplate {
    // Computed property to get habits as [HabitData]
    var habitList: [HabitData] {
        get {
            guard let raw = habitsData else { return [] }
            return raw.compactMap { dict in
                guard
                    let id = dict["id"] as? String,
                    let title = dict["title"] as? String,
                    let description = dict["description"] as? String,
                    let icon = dict["icon"] as? String
                else { return nil }
                return HabitData(id: id, title: title, description: description, icon: icon)
            }
        }
        set {
            // Convert [HabitData] → [[String: Any]] before saving
            habitsData = newValue.map { habit in
                [
                    "id": habit.id,
                    "title": habit.title,
                    "description": habit.description,
                    "icon": habit.icon
                ]
            }
        }
    }
}

struct HabitData: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
}
