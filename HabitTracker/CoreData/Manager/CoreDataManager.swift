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
        // Check if arc already exists
        let fetchRequest: NSFetchRequest<SubscribedArc> = SubscribedArc.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", arcTemplate.id ?? "")
        
        do {
            let existing = try context.fetch(fetchRequest)
            if let alreadySubscribed = existing.first {
                print("⚠️ Arc already subscribed: \(alreadySubscribed.arcTemplate?.title ?? "Unknown Arc")")
                let error = NSError(
                    domain: "CoreDataManager",
                    code: 409, // conflict
                    userInfo: [NSLocalizedDescriptionKey: "Arc already subscribed."]
                )
                return .failure(error)
            }
        } catch {
            print("❌ Failed to check duplicate arcs: \(error.localizedDescription)")
            return .failure(error)
        }
        
        // Create new subscription
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
        let totalHabits = arcTemplate.habitList.count
        let progress = ArcProgress(context: context)
        progress.id = UUID().uuidString
        progress.subscribedArc = subscribedArc
        progress.date = Calendar.current.startOfDay(for: Date())
        progress.totalHabits = Int16(totalHabits)
        progress.completedHabits = 0
        subscribedArc.addToProgressHistory(progress)
        
        // Save safely
        do {
            try context.save()
            print("✅ Subscribed to arc: \(arcTemplate.title ?? "Unknown")")
            return .success(subscribedArc)
        } catch {
            context.rollback()
            print("❌ Failed to subscribe to arc: \(error.localizedDescription)")
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
    
    
    
    // MARK: - Complete Arc
    func completeArc(_ subArc: SubscribedArc) {
        
        let history = History(context: context)
        history.arcId = subArc.id
        history.completedAt = Date()
        history.status = "completed"
        history.pointsEarned = "2"
        history.subscribedArc = subArc
        
        // Delete subscription after completion
        context.delete(subArc)
        saveContext()
    }
    
    func updateSubscribedArc(
           withId id: String,
           newIcon: String? = nil,
           newThemeColor: String? = nil
       ) -> Result<SubscribedArc, Error> {
           
           let request: NSFetchRequest<SubscribedArc> = SubscribedArc.fetchRequest()
           request.predicate = NSPredicate(format: "id == %@", id)
           request.fetchLimit = 1
           
           do {
               if let subArc = try context.fetch(request).first {
                   
                   if let icon = newIcon {
                       subArc.icon = icon
                   }
                   
                   if let color = newThemeColor {
                       subArc.themeColor = color
                   }
                   
                   try context.save()
                   return .success(subArc)
               } else {
                   return .failure(NSError(
                       domain: "CoreDataManager",
                       code: 404,
                       userInfo: [NSLocalizedDescriptionKey: "SubscribedArc not found"]
                   ))
               }
           } catch {
               context.rollback()
               return .failure(error)
           }
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
    
    // MARK: - Fetch Completed Arcs (History)
    func fetchAllHistories() -> [History] {
        let request: NSFetchRequest<History> = History.fetchRequest()
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
        // Check if already exists
        let fetchRequest: NSFetchRequest<SubscribedHabit> = SubscribedHabit.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", habitTemplate.id ?? "")
        
        do {
            let existing = try context.fetch(fetchRequest)
            if let alreadySubscribed = existing.first {
                print("⚠️ Habit already subscribed: \(alreadySubscribed.wrappedTitle)")
                let error = NSError(
                    domain: "CoreDataManager",
                    code: 409, // conflict
                    userInfo: [NSLocalizedDescriptionKey: "Habit already subscribed."]
                )
                completion(.failure(error))
                return
            }
        } catch {
            print("❌ Failed to check duplicates: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }
        
        // Create new subscription
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
    
    
    // MARK: - Update Subscribed Habit
        
        func updateSubscribedHabit(
            withId id: String,
            newIcon: String? = nil,
            newThemeColor: String? = nil
        ) -> Result<SubscribedHabit, Error> {
            
            let request: NSFetchRequest<SubscribedHabit> = SubscribedHabit.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)
            request.fetchLimit = 1
            
            do {
                if let subHabit = try context.fetch(request).first {
                    
                    if let icon = newIcon {
                        subHabit.icon = icon
                    }
                    
                    if let color = newThemeColor {
                        subHabit.themeColor = color
                    }
                    
                    try context.save()
                    return .success(subHabit)
                } else {
                    return .failure(NSError(
                        domain: "CoreDataManager",
                        code: 404,
                        userInfo: [NSLocalizedDescriptionKey: "SubscribedHabit not found"]
                    ))
                }
            } catch {
                context.rollback()
                return .failure(error)
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
            habit.id = hData["habitId"] as? String
            habit.title = hData["title"] as? String
            habit.details = hData["description"] as? String
            habit.category = hData["category"] as? [String]
            habit.colorToken = hData["themeColor"] as? String
            habit.icon = hData["icon"] as? String
            habit.defaultGoalPerDay = Int16(hData["defaultGoalPerDay"] as? Int ?? 1)
            if let pointsDict = hData["pointsPerDay"] as? [String: Int] {
                habit.pointsPerDay = pointsDict as NSObject
            }
            habit.tags = hData["tags"] as? NSObject
            
        }
        
        // Save ArcTemplates
        for aData in arcsArray {
            if let arcId = aData["id"] as? String, fetchArc(by: arcId) != nil {
                continue
            }
            
            let arc = ArcTemplate(context: context)
            arc.id = aData["arcId"] as? String
            arc.title = aData["title"] as? String
            arc.shortSubtitle = aData["shortSubtitle"] as? String
            arc.descriptionText = aData["description"] as? String
            arc.durationDays = Int16(aData["durationDays"] as? Int ?? 0)
            arc.category = aData["category"] as? [String]
            arc.colorToken = aData["themeColor"] as? String
            arc.coverImage = aData["coverImage"] as? String
            
            arc.benefits = aData["benefits"] as? [String]
            arc.habitsData = aData["habits"] as? [[String:Any]]
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
            
            
            // Link habits to Arc
//            if let habitRefs = aData["habits"] as? [[String: Any]] {
//                for ref in habitRefs {
//                    if let habitId = ref["habitId"] as? String {
//                        if let habit = fetchHabit(by: habitId) {
//                            arc.addToHabits(habit)
//                        } else {
//                            print("⚠️ Could not find habit with id \(habitId)")
//                        }
//                    }
//                }
//            }
            
            
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
            return arcs
        } catch {
            return []
        }
    }
    
    
//    func subscribeToFirstArc() -> SubscribedArc? {
//        let arcs = fetchAllArcs()
//        guard let firstArc = arcs.first else {
//            print("No arcs available to subscribe")
//            return nil
//        }
//        
//        let subscribedArc = SubscribedArc(context: context)
//        subscribedArc.id = firstArc.id
//        subscribedArc.arcTemplate = firstArc
//        subscribedArc.startDate = Date()
//        subscribedArc.endDate = Calendar.current.date(byAdding: .day, value: Int(firstArc.durationDays), to: Date())
//        subscribedArc.graceEndDate = Calendar.current.date(byAdding: .hour, value: 24, to: subscribedArc.endDate ?? Date())
//        subscribedArc.themeColor = firstArc.colorToken
//        subscribedArc.icon = firstArc.icons?["days"] ?? ""
//        
//        // Link habits from ArcTemplate to SubscribedHabit
//        if let habits = firstArc.habits as? Set<HabitTemplate> {
//            for habit in habits {
//                let subHabit = SubscribedHabit(context: context)
//                subHabit.id = habit.id
//                subHabit.habit = habit
//                subHabit.subscribedArc = subscribedArc
//                subHabit.requiredPerDay = habit.defaultGoalPerDay
//                subscribedArc.addToSubscribedHabits(subHabit)
//            }
//        }
//        
//        // ✅ Seed dummy progress history for last 2 days + today
//        let totalHabits = firstArc.habits?.count ?? 0
//        let calendar = Calendar.current
//        
//        for i in (-2...0) { // -2, -1, 0 → 2 days ago, yesterday, today
//            let progress = ArcProgress(context: context)
//            progress.id = UUID().uuidString
//            progress.subscribedArc = subscribedArc
//            progress.date = calendar.date(byAdding: .day, value: i, to: Date())
//            progress.totalHabits = Int16(totalHabits)
//            
//            // Dummy completed habits (random example, can be customized)
//            if totalHabits > 0 {
//                progress.completedHabits = Int16(Int.random(in: 0...totalHabits))
//            } else {
//                progress.completedHabits = 0
//            }
//            
//            subscribedArc.addToProgressHistory(progress)
//        }
//        saveContext()
//        return subscribedArc
//    }
}

extension CoreDataManager {
    func toggleArcHabit(
        _ habitId: String,
        in arc: SubscribedArc,
        completion: (Bool) -> Void
    ) {
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
        let isNowChecked: Bool
        
        if completed.contains(habitId) {
            // Uncheck
            completed.removeAll { $0 == habitId }
            isNowChecked = false
        } else {
            // Check
            completed.append(habitId)
            isNowChecked = true
        }
        
        progress.completedHabitIds = completed
        progress.completedHabits = Int16(completed.count)
        
        saveContext()
        
        // Call completion with final state
        completion(isNowChecked)
    }

    func toggleHabit(
        _ habitId: String,
        in habit: SubscribedHabit,
        completion: (Bool) -> Void
    ) {
        let today = Calendar.current.startOfDay(for: Date())

        // Fetch or create today's progress
        let progress = habit.todayProgress ?? {
            let newProgress = HabitProgress(context: context)
            newProgress.id = UUID().uuidString
            newProgress.date = today
            newProgress.subscribedHabit = habit
            newProgress.totalHabits = Int16(habit.wrappedRequiredPerDay) // expected per day
            newProgress.completedHabitIds = []
            newProgress.completedCount = 0
            habit.addToProgressHistory(newProgress)
            return newProgress
        }()

        var completed = progress.completedHabitIds ?? []
        let isNowChecked: Bool

        if completed.contains(habitId) {
            // Uncheck
            completed.removeAll { $0 == habitId }
            isNowChecked = false
        } else {
            // Check
            completed.append(habitId)
            isNowChecked = true
        }

        progress.completedHabitIds = completed
        progress.completedCount = Int16(completed.count)

        saveContext()

        // Call closure with updated state
        completion(isNowChecked)
    }


}

extension CoreDataManager {
    // MARK: - Expire Arcs
    func checkAndCompleteExpiredArcs() {
        let now = Date()
        let request: NSFetchRequest<SubscribedArc> = SubscribedArc.fetchRequest()
        
        do {
            let subscribedArcs = try context.fetch(request)
            for subArc in subscribedArcs {
                if let endDate = subArc.endDate, now > endDate {
                    completeArc(subArc)
                }
            }
            saveContext()
        } catch {
            print("Failed to fetch subscribed arcs: \(error)")
        }
    }
    
}


// MARK: - Statistics

extension CoreDataManager {
    
    /// Fetch today's statistics (or create if missing)
    func fetchOrCreateTodayStatistics() -> Statistics {
        let today = Calendar.current.startOfDay(for: Date())
        let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", today as NSDate)
        
        if let existing = try? context.fetch(request).first {
            return existing
        }
        
        let stats = Statistics(context: context)
        stats.id = UUID()
        stats.date = today
        saveContext()
        return stats
    }
    
    /// Add points to category
    func addPoints(to category: Statistics.Category, points: Int32 = 1) {
        let stats = fetchOrCreateTodayStatistics()
        stats.addPoints(to: category, points: points)
        saveContext()
    }
    
    /// Remove points
    func removePoints(from category: Statistics.Category, points: Int32 = 1) {
        let stats = fetchOrCreateTodayStatistics()
        stats.removePoints(from: category, points: points)
        saveContext()
    }
    
    /// Fetch all statistics records
    func fetchAllStatistics() -> [Statistics] {
        let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Statistics.date, ascending: true)]
        return (try? context.fetch(request)) ?? []
    }
    
    /// Delete a specific statistics record
    func deleteStatistics(_ stats: Statistics) {
        context.delete(stats)
        saveContext()
    }
    
    /// Daily totals for one stats object
    func totals(for stats: Statistics) -> (discipline: Int32, strength: Int32, confidence: Int32, intelligence: Int32, overall: Int32) {
        return (
            stats.disciplineTotal,
            stats.strengthTotal,
            stats.confidenceTotal,
            stats.intelligenceTotal,
            stats.overallTotal
        )
    }
    
    /// Grand totals across all records
    func grandTotals() -> (discipline: Int32, strength: Int32, confidence: Int32, intelligence: Int32, overall: Int32) {
        let all = fetchAllStatistics()
        let discipline = all.reduce(0) { $0 + $1.disciplineTotal }
        let strength = all.reduce(0) { $0 + $1.strengthTotal }
        let confidence = all.reduce(0) { $0 + $1.confidenceTotal }
        let intelligence = all.reduce(0) { $0 + $1.intelligenceTotal }
        let overall = all.reduce(0) { $0 + $1.overallTotal }
        
        return (discipline, strength, confidence, intelligence, overall)
    }
    
}

extension CoreDataManager {
    func fetchWeeklyStatistics() -> [Statistics] {
        let context = self.context
        let request: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        
        let calendar = Calendar.current
        let today = Date()
        
        // Find Monday of current week
        let weekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        let weekEnd = calendar.date(byAdding: .day, value: 7, to: weekStart)!
        
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", weekStart as NSDate, weekEnd as NSDate)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Failed to fetch weekly statistics: \(error)")
            return []
        }
    }
}





//For the dummy data use only
extension CoreDataManager {

    // MARK: - Fetch helpers
    func fetchSubscribedArc(by id: String) -> SubscribedArc? {
        let request: NSFetchRequest<SubscribedArc> = SubscribedArc.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.fetchLimit = 1
        do {
            return try context.fetch(request).first
        } catch {
            print("❌ Failed to fetch SubscribedArc:", error)
            return nil
        }
    }

    

    func fetchHistory(by id: UUID) -> History? {
        let request: NSFetchRequest<History> = History.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.fetchLimit = 1
        do {
            return try context.fetch(request).first
        } catch {
            print("❌ Failed to fetch History:", error)
            return nil
        }
    }

    
    // MARK: - Save SubscribedArc + History from JSON
//    func saveSubscribedArcHistoryFromJSON(_ json: [String: Any]) {
//        guard let subscribedArcsArray = json["subscribedArcs"] as? [[String: Any]],
//              let historyArray = json["history"] as? [[String: Any]] else {
//            print("❌ Invalid JSON structure")
//            return
//        }
//
//        let dateFormatter = ISO8601DateFormatter()
//
//        // Save SubscribedArcs
//        for saData in subscribedArcsArray {
//            guard let arcId = saData["id"] as? String else { continue }
//
//            // Skip if already exists
//            if fetchSubscribedArc(by: arcId) != nil { continue }
//
//            let subscribedArc = SubscribedArc(context: context)
//            subscribedArc.id = arcId
//            subscribedArc.startDate = (saData["startDate"] as? String).flatMap { dateFormatter.date(from: $0) }
//            subscribedArc.endDate = (saData["endDate"] as? String).flatMap { dateFormatter.date(from: $0) }
//            subscribedArc.graceEndDate = (saData["graceEndDate"] as? String).flatMap { dateFormatter.date(from: $0) }
//            subscribedArc.themeColor = saData["themeColor"] as? String
//            subscribedArc.icon = saData["icon"] as? String
//
//            print("✅ SubscribedArc saved with id: \(arcId)")
//        }
//
//        // Save History
//        for hData in historyArray {
//            guard let historyIdString = hData["id"] as? String,
//                  let historyUUID = UUID(uuidString: historyIdString) else {
//                print("⚠️ Invalid history ID (not UUID): \(String(describing: hData["id"]))")
//                continue
//            }
//
//            // Skip if already exists
//            if fetchHistory(by: historyUUID) != nil {
//                print("⏭ Skipped duplicate history with id: \(historyUUID)")
//                continue
//            }
//
//            let history = History(context: context)
//            history.id = historyUUID
//            history.arcId = hData["arcId"] as? String
//            history.arcTitle = hData["arcTitle"] as? String
//            history.arcType = hData["arcType"] as? String
//            history.arcDays = Int32(hData["arcDays"] as? Int ?? 0)
//            history.color = hData["color"] as? String
//            history.pointsEarned = hData["pointsEarned"] as? String
//            history.status = hData["status"] as? String
//            history.completedAt = (hData["completedAt"] as? String).flatMap { dateFormatter.date(from: $0) }
//            history.expiredAt = (hData["expiredAt"] as? String).flatMap { dateFormatter.date(from: $0) }
//
//            // Link to SubscribedArc
//            if let subscribedArcId = hData["subscribedArc"] as? String,
//               let subscribedArc = fetchSubscribedArc(by: subscribedArcId) {
//                history.subscribedArc = subscribedArc
//            }
//
//            print("✅ History saved with id: \(historyUUID)")
//        }
//
//        saveContext()
//
//        let total = fetchAllHistories().count
//        print("🎉 JSON saved successfully (\(total) histories in Core Data)")
//    }
}
