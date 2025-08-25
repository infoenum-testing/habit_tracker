//
//  CoreDataManager.swift
//  HabitTracker
//
//  Created by IE14 on 25/08/25.
//

import Foundation
import CoreData
import UIKit

// MARK: - CoreDataManager

import Foundation
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "HabitTrackerDataBase") // your .xcdatamodeld name
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data store failed: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Save Context
    func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    // MARK: - Seed Initial JSON (only once)
    func seedInitialData(habitsJSON: [[String: Any]], arcsJSON: [[String: Any]]) {
        // Check if already seeded
        let fetchRequest: NSFetchRequest<HabitTemplate> = HabitTemplate.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        if (try? context.fetch(fetchRequest))?.isEmpty == false { return }
        
        // Create Habits
        for hData in habitsJSON {
            let habit = HabitTemplate(context: context)
            habit.id = hData["id"] as? String
            habit.title = hData["title"] as? String
            habit.details = hData["description"] as? String
            habit.category = hData["category"] as? String
            habit.colorToken = hData["colorToken"] as? String
            habit.icon = hData["icon"] as? String
            habit.defaultGoalPerDay = Int16(hData["defaultGoalPerDay"] as? Int ?? 1)
            
            if let points = hData["pointsPerDay"] as? [String: Int] {
                habit.pointsEasy = Int16(points["easy"] ?? 0)
                habit.pointsMedium = Int16(points["medium"] ?? 0)
                habit.pointsHard = Int16(points["hard"] ?? 0)
            }
            
            habit.tags = hData["tags"] as? NSObject
            
            if let createdAtStr = hData["metaCreatedAt"] as? String {
                habit.metaCreatedAt = ISO8601DateFormatter().date(from: createdAtStr)
            }
            if let updatedAtStr = hData["metaUpdatedAt"] as? String {
                habit.metaUpdatedAt = ISO8601DateFormatter().date(from: updatedAtStr)
            }
            habit.metaAuthor = hData["metaAuthor"] as? String
        }
        
        // Create Arcs
        for aData in arcsJSON {
            let arc = ArcTemplate(context: context)
            arc.id = aData["id"] as? String
            arc.title = aData["title"] as? String
            arc.shortSubtitle = aData["shortSubtitle"] as? String
            arc.deatilDescription = aData["description"] as? String
            arc.durationDays = Int16(aData["durationDays"] as? Int ?? 0)
            arc.category = aData["category"] as? String
            arc.colorToken = aData["colorToken"] as? String
            arc.coverImage = aData["coverImage"] as? String
            arc.benefits = aData["benefits"] as? NSObject
            arc.icons = aData["icons"] as? NSObject
            arc.tags = aData["tags"] as? NSObject
            if let createdAtStr = aData["metaCreatedAt"] as? String {
                arc.metaCreatedAt = ISO8601DateFormatter().date(from: createdAtStr)
            }
            if let updatedAtStr = aData["metaUpdatedAt"] as? String {
                arc.metaUpdatedAt = ISO8601DateFormatter().date(from: updatedAtStr)
            }
            arc.metaAuthor = aData["metaAuthor"] as? String
            
            // Link Habits
            if let habitRefs = aData["habitRefs"] as? [[String: Any]] {
                for ref in habitRefs {
                    if let habitId = ref["habitId"] as? String,
                       let habit = fetchHabit(by: habitId) {
                        arc.addToHabits(habit)
                    }
                }
            }
        }
        
        saveContext()
        print("Initial JSON data seeded!")
    }
    
    // MARK: - Fetch Habits & Arcs
    func fetchAllHabits() -> [HabitTemplate] {
        let request: NSFetchRequest<HabitTemplate> = HabitTemplate.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func fetchAllArcs() -> [ArcTemplate] {
        let request: NSFetchRequest<ArcTemplate> = ArcTemplate.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func fetchHabit(by id: String) -> HabitTemplate? {
        let request: NSFetchRequest<HabitTemplate> = HabitTemplate.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        return (try? context.fetch(request))?.first
    }
    
    func fetchArc(by id: String) -> ArcTemplate? {
        let request: NSFetchRequest<ArcTemplate> = ArcTemplate.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        return (try? context.fetch(request))?.first
    }
    
    // MARK: - Subscribe to Arc
    func subscribeArc(_ arc: ArcTemplate) -> SubscribedArc {
        let subArc = SubscribedArc(context: context)
        subArc.id = arc.id
        subArc.arcTemplate = arc
        subArc.startDate = Date()
        subArc.endDate = Calendar.current.date(byAdding: .day, value: Int(arc.durationDays), to: Date())
        subArc.status = "active"
        
        // Create SubscribedHabits
        if let habitsSet = arc.habits as? Set<HabitTemplate> {
            for habit in habitsSet {
                let subHabit = SubscribedHabit(context: context)
                subHabit.id = habit.id
                subHabit.habit = habit
                subHabit.requiredPerDay = habit.defaultGoalPerDay
                subHabit.completedToday = 0
                subHabit.totalCompleted = 0
                subHabit.status = "active"
                subHabit.lastUpdated = Date()
                subHabit.subscribedArc = subArc
                subArc.addToSubscribedHabits(subHabit)
            }
        }
        
        saveContext()
        return subArc
    }
    
    // MARK: - Complete Arc
    func completeArc(_ subArc: SubscribedArc) {
        subArc.status = "completed"
        
        let history = History(context: context)
        history.arcId = subArc.id
        history.completedAt = Date()
        history.status = "completed"
        history.pointsEarned = "2"
        history.subscribedArc = subArc
        subArc.history = history
        
        // Create Badge
        let badge = Badge(context: context)
        badge.arcType = subArc.arcTemplate?.title
        badge.completionDate = Date()
        badge.color = subArc.arcTemplate?.colorToken
        
        // Delete subscription
        context.delete(subArc)
        saveContext()
    }
    
    // MARK: - Delete Subscription
    func deleteSubscribedArc(_ subArc: SubscribedArc) {
        context.delete(subArc)
        saveContext()
    }
    
    // MARK: - Fetch Subscribed Arcs
    func fetchSubscribedArcs() -> [SubscribedArc] {
        let request: NSFetchRequest<SubscribedArc> = SubscribedArc.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
}
