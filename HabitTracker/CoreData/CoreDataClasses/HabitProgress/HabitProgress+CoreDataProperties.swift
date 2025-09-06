//
//  HabitProgress+CoreDataProperties.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 29/08/25.
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

extension HabitProgress {
    convenience init(context: NSManagedObjectContext, date: Date, habit: SubscribedHabit) {
        self.init(context: context)
        self.id = UUID().uuidString
        self.date = date
        self.subscribedHabit = habit
        self.totalHabits = Int16(habit.wrappedRequiredPerDay) // expected per day
        self.completedHabitIds = []
        self.completedCount = 0
        habit.addToProgressHistory(self)
    }
}



