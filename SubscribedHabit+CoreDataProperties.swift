//
//  SubscribedHabit+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 25/08/25.
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
    @NSManaged public var completedToday: Int16
    @NSManaged public var totalCompleted: Int16
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var status: String?
    @NSManaged public var habit: HabitTemplate?
    @NSManaged public var subscribedArc: SubscribedArc?

}

extension SubscribedHabit : Identifiable {

}
