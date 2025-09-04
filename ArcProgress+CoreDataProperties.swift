//
//  ArcProgress+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 28/08/25.
//
//

import Foundation
import CoreData


extension ArcProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArcProgress> {
        return NSFetchRequest<ArcProgress>(entityName: "ArcProgress")
    }

    @NSManaged public var id: String?
    @NSManaged public var date: Date?
    @NSManaged public var completedHabits: Int16
    @NSManaged public var totalHabits: Int16
    @NSManaged public var subscribedArc: SubscribedArc?
    @NSManaged public var completedHabitIds: [String]?
    @NSManaged public var pointsAwarded: Bool


}

extension ArcProgress : Identifiable {

}

extension ArcProgress {
    convenience init(context: NSManagedObjectContext, date: Date, arc: SubscribedArc) {
        self.init(context: context)
        self.id = UUID().uuidString
        self.date = date
        self.subscribedArc = arc
        self.totalHabits = Int16(arc.wrappedHabitsCount)
        self.completedHabitIds = []
        arc.addToProgressHistory(self)
    }
}
