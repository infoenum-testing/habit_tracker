//
//  HabitTemplate+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 25/08/25.
//
//

import Foundation
import CoreData


extension HabitTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HabitTemplate> {
        return NSFetchRequest<HabitTemplate>(entityName: "HabitTemplate")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var category: String?
    @NSManaged public var colorToken: String?
    @NSManaged public var icon: String?
    @NSManaged public var defaultGoalPerDay: Int16
    @NSManaged public var pointsEasy: Int16
    @NSManaged public var pointsMedium: Int16
    @NSManaged public var pointsHard: Int16
    @NSManaged public var tags: NSObject?
    @NSManaged public var metaCreatedAt: Date?
    @NSManaged public var metaUpdatedAt: Date?
    @NSManaged public var metaAuthor: String?
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
