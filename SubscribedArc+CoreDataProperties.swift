//
//  SubscribedArc+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 26/08/25.
//
//

import Foundation
import CoreData


extension SubscribedArc {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubscribedArc> {
        return NSFetchRequest<SubscribedArc>(entityName: "SubscribedArc")
    }

    @NSManaged public var endDate: Date?
    @NSManaged public var graceEndDate: Date?
    @NSManaged public var id: String?
    @NSManaged public var pointsEarned: Int32
    @NSManaged public var startDate: Date?
    @NSManaged public var status: String?
    @NSManaged public var arcTemplate: ArcTemplate?
    @NSManaged public var history: History?
    @NSManaged public var subscribedHabits: NSSet?

}

// MARK: Generated accessors for subscribedHabits
extension SubscribedArc {

    @objc(addSubscribedHabitsObject:)
    @NSManaged public func addToSubscribedHabits(_ value: SubscribedHabit)

    @objc(removeSubscribedHabitsObject:)
    @NSManaged public func removeFromSubscribedHabits(_ value: SubscribedHabit)

    @objc(addSubscribedHabits:)
    @NSManaged public func addToSubscribedHabits(_ values: NSSet)

    @objc(removeSubscribedHabits:)
    @NSManaged public func removeFromSubscribedHabits(_ values: NSSet)

}

extension SubscribedArc : Identifiable {

}
