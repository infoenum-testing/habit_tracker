//
//  Badge+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 26/08/25.
//
//

import Foundation
import CoreData


extension Badge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Badge> {
        return NSFetchRequest<Badge>(entityName: "Badge")
    }

   
    @NSManaged public var arcDays: Int32
    @NSManaged public var arcId: String?
    @NSManaged public var arcTitle: String?
    @NSManaged public var arcType: String?
    @NSManaged public var color: String?
    @NSManaged public var completionDate: Date?
    @NSManaged public var id: UUID?

}

extension Badge : Identifiable {

}
