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
// MARK: - Arcs

final class CoreDataManager {

    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "HabitTrackerDataBase")
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
    
    // MARK: - Fetch Arcs
   
    func fetchAllArcs() -> [ArcTemplate] {
        let request: NSFetchRequest<ArcTemplate> = ArcTemplate.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    
    func fetchArc(by id: String) -> ArcTemplate? {
        let request: NSFetchRequest<ArcTemplate> = ArcTemplate.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        return (try? context.fetch(request))?.first
    }
    
    // MARK: - Subscribe to Arc
    func subscribeArc(to arcTemplate: ArcTemplate) -> Result<SubscribedArc, Error> {
        let subscribedArc = SubscribedArc(context: context)
        subscribedArc.id = arcTemplate.id
        subscribedArc.arcTemplate = arcTemplate
        subscribedArc.startDate = Date()
        subscribedArc.endDate = Calendar.current.date(
            byAdding: .day,
            value: Int(arcTemplate.durationDays),
            to: Date()
        )
        subscribedArc.graceEndDate = Calendar.current.date(
            byAdding: .hour,
            value: 24,
            to: subscribedArc.endDate ?? Date()
        )
        subscribedArc.themeColor = arcTemplate.colorToken
        subscribedArc.icon = arcTemplate.icons?["days"] ?? ""
        
        // Create ArcProgress only for today
        let totalHabits = arcTemplate.habits?.count ?? 0
        let calendar = Calendar.current
        let progress = ArcProgress(context: context)
        progress.id = UUID().uuidString
        progress.subscribedArc = subscribedArc
        progress.date = calendar.startOfDay(for: Date())
        progress.totalHabits = Int16(totalHabits)
        progress.completedHabits = 0
        subscribedArc.addToProgressHistory(progress)
        
        // Save safely
        do {
            try context.save()
            return .success(subscribedArc)
        } catch {
            context.rollback() // revert any partial inserts
            return .failure(error)
        }
    }

    // MARK: - Unsubscribe to Arc

    func unsubscribeArc(withId id: String) -> Result<Void, Error> {
            let context = persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<SubscribedArc> = SubscribedArc.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)

            do {
                if let arc = try context.fetch(fetchRequest).first {
                    context.delete(arc)
                    try context.save()
                    return .success(())
                } else {
                    return .failure(NSError(domain: "CoreDataManager",
                                            code: 404,
                                            userInfo: [NSLocalizedDescriptionKey: "Arc not found"]))
                }
            } catch {
                return .failure(error)
            }
        }
    
    // MARK: - Fetch Badges
    func fetchAllBadges() -> [Badge] {
        let request: NSFetchRequest<Badge> = Badge.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }

    
    // MARK: - Complete Arc
    func completeArc(_ subArc: SubscribedArc) {
        
        let history = History(context: context)
        history.arcId = subArc.id
        history.completedAt = Date()
        history.status = "completed"
        history.pointsEarned = "2"
        history.subscribedArc = subArc
        
        // Create Badge
        if let arc = subArc.arcTemplate {
            let badge = Badge(context: context)
            badge.id = UUID()
            badge.arcId = arc.id
            badge.arcTitle = arc.title
            badge.arcType = arc.category
            badge.arcDays = Int32(arc.durationDays)
            badge.color = arc.colorToken
            badge.completionDate = Date()
        }
        
        // Delete subscription after completion
        context.delete(subArc)
        saveContext()
    }

    
    // MARK: - Delete Subscribed Arc
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

// MARK: - Habits
extension CoreDataManager {
    
    func fetchAllHabits() -> [HabitTemplate] {
        let request: NSFetchRequest<HabitTemplate> = HabitTemplate.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    func fetchHabit(by id: String) -> HabitTemplate? {
        let request: NSFetchRequest<HabitTemplate> = HabitTemplate.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        return (try? context.fetch(request))?.first
    }
    
    // MARK: - Delete Subscribed Arc
    func deleteSubscribedHabit(_ subArc: SubscribedHabit) {
        context.delete(subArc)
        saveContext()
    }
    
    /// Subscribe to a habit directly (without Arc)
     func subscribeHabit(
        from habitTemplate: HabitTemplate,
        requiredPerDay: Int16 = 1,
        completion: @escaping (Result<SubscribedHabit, Error>) -> Void
    ) {
       // let context = persistentContainer.viewContext
        let subscribedHabit = SubscribedHabit(context: context)
        subscribedHabit.id = habitTemplate.id ?? UUID().uuidString
        subscribedHabit.habit = habitTemplate
        subscribedHabit.requiredPerDay = requiredPerDay
        subscribedHabit.icon = habitTemplate.icon ?? "default_icon"
        subscribedHabit.themeColor = habitTemplate.colorToken ?? "blue"
        subscribedHabit.startDate = Date()
        
        do {
            try context.save()
            print("✅ Subscribed to habit: \(habitTemplate.title ?? "Unknown")")
            completion(.success(subscribedHabit))
        } catch {
            context.rollback()
            print("❌ Failed to subscribe to habit: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    /// Unsubscribe a habit (delete from Core Data)
     func unsubscribeHabit(
        habitID: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let request: NSFetchRequest<SubscribedHabit> = SubscribedHabit.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", habitID)
        
        do {
            if let habitToDelete = try context.fetch(request).first {
                context.delete(habitToDelete)
                try context.save()
                print("🗑️ Unsubscribed habit with id: \(habitID)")
                completion(.success(()))
            } else {
                let notFoundError = NSError(
                    domain: "SubscribedHabit",
                    code: 404,
                    userInfo: [NSLocalizedDescriptionKey: "Habit not found for id: \(habitID)"]
                )
                completion(.failure(notFoundError))
            }
        } catch {
            context.rollback()
            print("❌ Failed to unsubscribe habit: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func fetchSubscribedHabits() -> [SubscribedHabit] {
        let request: NSFetchRequest<SubscribedHabit> = SubscribedHabit.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
}





extension CoreDataManager {

    /// Save habits and arcs from JSON
    func saveDataFromJSON(_ json: [String: Any]) {
        guard let habitsArray = json["habits"] as? [[String: Any]],
              let arcsArray = json["arcs"] as? [[String: Any]] else {
            print("Invalid JSON structure")
            return
        }
        
        // Save Habits
        for hData in habitsArray {
            // Check if habit already exists
            if let habitId = hData["id"] as? String, fetchHabit(by: habitId) != nil {
                continue
            }
            
            let habit = HabitTemplate(context: context)
            habit.id = hData["id"] as? String
            habit.title = hData["title"] as? String
            habit.details = hData["description"] as? String
            habit.category = hData["category"] as? String
            habit.colorToken = hData["colorToken"] as? String
            habit.icon = hData["icon"] as? String
            habit.defaultGoalPerDay = Int16(hData["defaultGoalPerDay"] as? Int ?? 1)
            if let pointsDict = hData["pointsPerDay"] as? [String: Int] {
                habit.pointsPerDay = pointsDict as NSObject
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
        
        // Save ArcTemplates
        for aData in arcsArray {
            if let arcId = aData["id"] as? String, fetchArc(by: arcId) != nil {
                continue
            }
            
            let arc = ArcTemplate(context: context)
            arc.id = aData["id"] as? String
            arc.title = aData["title"] as? String
            arc.shortSubtitle = aData["shortSubtitle"] as? String
            arc.descriptionText = aData["description"] as? String
            arc.durationDays = Int16(aData["durationDays"] as? Int ?? 0)
            arc.category = aData["category"] as? String
            arc.colorToken = aData["colorToken"] as? String
            arc.coverImage = aData["coverImage"] as? String
            
            arc.benefits = aData["benefits"] as? [String]
            if let iconsDict = aData["icons"] as? [String: String] {
                arc.icons = iconsDict
            }
            
            if let pointsDict = aData["pointsPerDay"] as? [String: Any] {
                arc.pointsPerDay = pointsDict
            }

            // tags
            if let tagsArray = aData["tags"] as? [String] {
                arc.tags = tagsArray
            }
            
            if let createdAtStr = aData["metaCreatedAt"] as? String {
                arc.metaCreatedAt = ISO8601DateFormatter().date(from: createdAtStr)
            }
            if let updatedAtStr = aData["metaUpdatedAt"] as? String {
                arc.metaUpdatedAt = ISO8601DateFormatter().date(from: updatedAtStr)
            }
            arc.metaAuthor = aData["metaAuthor"] as? String
            
            // Link habits to Arc
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
        print("JSON data saved successfully!")
    }
}




import Foundation
import CoreData

extension CoreDataManager {
    
    /// Fetch all ArcTemplates and print
    func fetchAllArcsData() -> [ArcTemplate] {
        let request: NSFetchRequest<ArcTemplate> = ArcTemplate.fetchRequest()
        
        do {
            let arcs = try context.fetch(request)
            print("Fetched Arcs: \(arcs.count)")
            for arc in arcs {
                print("""
                Arc ID: \(arc.id ?? "")
                Title: \(arc.title ?? "")
                Duration: \(arc.durationDays) days
                Category: \(arc.category ?? "")
                """)
            }
            return arcs
        } catch {
            print("Failed to fetch arcs: \(error)")
            return []
        }
    }
}

extension CoreDataManager {
    func toggleHabit(_ habitId: String, in arc: SubscribedArc) {
        let today = Calendar.current.startOfDay(for: Date())

        // Fetch or create today's progress
        let progress = arc.todayProgress ?? {
            let newProgress = ArcProgress(context: context)
            newProgress.id = UUID().uuidString
            newProgress.date = today
            newProgress.subscribedArc = arc
            newProgress.totalHabits = Int16(arc.wrappedHabitsCount)
            newProgress.completedHabitIds = []
            arc.addToProgressHistory(newProgress)
            return newProgress
        }()

        var completed = progress.completedHabitIds ?? []

        if completed.contains(habitId) {
            // Uncheck
            completed.removeAll { $0 == habitId }
        } else {
            // Check
            completed.append(habitId)
        }

        progress.completedHabitIds = completed
        progress.completedHabits = Int16(completed.count)

        saveContext()
    }
    
    
    func toggleHabit(_ habitId: String, in habit: SubscribedHabit) {
        let today = Calendar.current.startOfDay(for: Date())

        // Fetch or create today's progress
        let progress = habit.todayProgress ?? {
            let newProgress = HabitProgress(context: context)
            newProgress.id = UUID().uuidString
            newProgress.date = today
            newProgress.subscribedHabit = habit
           // newProgress.totalHabits = Int16(habit.wrappedHabitsCount)
            newProgress.completedHabitIds = []
            habit.addToProgressHistory(newProgress)
            return newProgress
        }()

        var completed = progress.completedHabitIds ?? []

        if completed.contains(habitId) {
            // Uncheck
            completed.removeAll { $0 == habitId }
        } else {
            // Check
            completed.append(habitId)
        }

        progress.completedHabitIds = completed
        //progress.completedHabits = Int16(completed.count)

        saveContext()
    }
}


extension CoreDataManager {
    
    // Dummy badge seeding
    func seedDummyBadges() {
        // Example arc JSON data (hardcoded for now)
        let arcs: [[String: Any]] = [
            [
                "id": "arc-guthealth",
                "title": "Gut Health Arc",
                "durationDays": 60,
                "category": "Health",
                "colorToken": "green"
            ],
            [
                "id": "arc-dentalcare",
                "title": "Dental Care Arc",
                "durationDays": 30,
                "category": "Health",
                "colorToken": "blue"
            ],
            [
                "id": "arc-wellness",
                "title": "Wellness Arc",
                "durationDays": 45,
                "category": "Health",
                "colorToken": "orange"
            ]
        ]
        
        for arc in arcs {
            let badge = Badge(context: context)
            badge.id = UUID()
            badge.arcId = arc["id"] as? String
            badge.arcTitle = arc["title"] as? String
            badge.arcType = arc["category"] as? String
            badge.arcDays = Int32(arc["durationDays"] as? Int ?? 0)
            badge.color = arc["colorToken"] as? String
            badge.completionDate = Date()
        }
        
        saveContext()
    }
}
