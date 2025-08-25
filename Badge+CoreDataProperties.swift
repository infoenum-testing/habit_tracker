//
//  Badge+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 25/08/25.
//
//

import Foundation
import CoreData


extension Badge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Badge> {
        return NSFetchRequest<Badge>(entityName: "Badge")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var arcType: String?
    @NSManaged public var completionDate: Date?
    @NSManaged public var color: String?

}

extension Badge : Identifiable {

}
