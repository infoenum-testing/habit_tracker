//
//  History+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Apple on 03/09/25.
//
//

import Foundation
import CoreData


enum ArcStatus: String {
    case endByUser = "endbyuser"
    case expired = "expired"
    case completed = "completed"
}


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var arcDays: Int32
    @NSManaged public var arcId: String?
    @NSManaged public var arcTitle: String?
    @NSManaged public var arcType: String?
    @NSManaged public var color: String?
    @NSManaged public var completedAt: Date?
    @NSManaged public var startAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var pointsEarned: String?
    @NSManaged public var status: String?
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

extension History {
    var arcStatus: ArcStatus? {
        get {
            guard let rawValue = status else { return nil }
            return ArcStatus(rawValue: rawValue)
        }
        set {
            status = newValue?.rawValue
        }
    }
}
