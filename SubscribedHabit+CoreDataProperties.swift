//
//  SubscribedHabit+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 28/08/25.
//
//

import Foundation
import CoreData


extension SubscribedHabit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubscribedHabit> {
        return NSFetchRequest<SubscribedHabit>(entityName: "SubscribedHabit")
    }

    @NSManaged public var id: String?
    @NSManaged public var requiredPerDay: Int16
    @NSManaged public var icon: String?
    @NSManaged public var themeColor: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var habit: HabitTemplate?
    @NSManaged public var subscribedArc: SubscribedArc?
    @NSManaged public var progressHistory: NSSet?

}

// MARK: Generated accessors for progressHistory
extension SubscribedHabit {

    @objc(addProgressHistoryObject:)
    @NSManaged public func addToProgressHistory(_ value: HabitProgress)

    @objc(removeProgressHistoryObject:)
    @NSManaged public func removeFromProgressHistory(_ value: HabitProgress)

    @objc(addProgressHistory:)
    @NSManaged public func addToProgressHistory(_ values: NSSet)

    @objc(removeProgressHistory:)
    @NSManaged public func removeFromProgressHistory(_ values: NSSet)

}

extension SubscribedHabit : Identifiable {

}
