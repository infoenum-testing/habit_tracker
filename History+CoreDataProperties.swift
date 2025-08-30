//
//  History+CoreDataProperties.swift
//  HabitTracker
//
//  Created by ie15 on 29/08/25.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var arcId: String?
    @NSManaged public var completedAt: Date?
    @NSManaged public var expiredAt: Date?
    @NSManaged public var pointsEarned: String?
    @NSManaged public var status: String?
    @NSManaged public var id: UUID?
    @NSManaged public var color: String?
    @NSManaged public var arcDays: Int32
    @NSManaged public var arcTitle: String?
    @NSManaged public var arcType: String?
    @NSManaged public var habits: NSSet?
    @NSManaged public var subscribedArc: SubscribedArc?

}

// MARK: Generated accessors for habits
extension History {

    @objc(addHabitsObject:)
    @NSManaged public func addToHabits(_ value: SubscribedHabit)

    @objc(removeHabitsObject:)
    @NSManaged public func removeFromHabits(_ value: SubscribedHabit)

    @objc(addHabits:)
    @NSManaged public func addToHabits(_ values: NSSet)

    @objc(removeHabits:)
    @NSManaged public func removeFromHabits(_ values: NSSet)

}

extension History : Identifiable {

}
