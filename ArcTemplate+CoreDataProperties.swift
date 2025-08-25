//
//  ArcTemplate+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 25/08/25.
//
//

import Foundation
import CoreData


extension ArcTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArcTemplate> {
        return NSFetchRequest<ArcTemplate>(entityName: "ArcTemplate")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var shortSubtitle: String?
    @NSManaged public var deatilDescription: String?
    @NSManaged public var durationDays: Int16
    @NSManaged public var category: String?
    @NSManaged public var colorToken: String?
    @NSManaged public var coverImage: String?
    @NSManaged public var benefits: NSObject?
    @NSManaged public var habitRefs: NSObject?
    @NSManaged public var pointsEasy: Int16
    @NSManaged public var pointsMedium: Int16
    @NSManaged public var pointsHard: Int16
    @NSManaged public var icons: NSObject?
    @NSManaged public var tags: NSObject?
    @NSManaged public var metaCreatedAt: Date?
    @NSManaged public var metaUpdatedAt: Date?
    @NSManaged public var metaAuthor: String?
    @NSManaged public var habits: NSSet?
    @NSManaged public var subscribedArcs: NSSet?

}

// MARK: Generated accessors for habits
extension ArcTemplate {

    @objc(addHabitsObject:)
    @NSManaged public func addToHabits(_ value: HabitTemplate)

    @objc(removeHabitsObject:)
    @NSManaged public func removeFromHabits(_ value: HabitTemplate)

    @objc(addHabits:)
    @NSManaged public func addToHabits(_ values: NSSet)

    @objc(removeHabits:)
    @NSManaged public func removeFromHabits(_ values: NSSet)

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
