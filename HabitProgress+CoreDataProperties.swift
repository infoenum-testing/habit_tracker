//
//  HabitProgress+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 29/08/25.
//
//

import Foundation
import CoreData


extension HabitProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HabitProgress> {
        return NSFetchRequest<HabitProgress>(entityName: "HabitProgress")
    }

    @NSManaged public var completedCount: Int16
    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var totalHabits: Int16
    @NSManaged public var completedHabitIds: [String]?
    @NSManaged public var subscribedHabit: SubscribedHabit?

}

extension HabitProgress : Identifiable {

}
