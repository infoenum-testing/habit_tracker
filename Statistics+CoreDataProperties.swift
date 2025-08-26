//
//  Statistics+CoreDataProperties.swift
//  HabitTracker
//
//  Created by IE14 on 26/08/25.
//
//

import Foundation
import CoreData


extension Statistics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Statistics> {
        return NSFetchRequest<Statistics>(entityName: "Statistics")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var disciplineTotal: Int32
    @NSManaged public var strengthTotal: Int32
    @NSManaged public var confidenceTotal: Int32
    @NSManaged public var intelligenceTotal: Int32
    @NSManaged public var overallTotal: Int32
    @NSManaged public var disciplineDelta: Int32
    @NSManaged public var strengthDelta: Int32
    @NSManaged public var confidenceDelta: Int32
    @NSManaged public var intelligenceDelta: Int32
    @NSManaged public var overallDelta: Int32

}

extension Statistics : Identifiable {

}
