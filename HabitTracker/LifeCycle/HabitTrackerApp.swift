//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    @StateObject private var state = AppState(arcs: MockData.arcs, habits: MockData.habits)
    @StateObject private var appState = AppDataStore()
    @StateObject private var router = NavigationRouter()
    
    init() {
            loadInitialData()
        //loadSubscribedArcHistoryData()
       // CoreDataManager.shared.seedDummyBadges()
        CoreDataManager.shared.checkAndCompleteExpiredArcs()
        }
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(state)
                .environmentObject(router)
                .environmentObject(appState)
                .preferredColorScheme(.dark)
        }
    }
    
    func loadInitialData() {
        // 1. Locate the JSON file in the app bundle
        guard let url = Bundle.main.url(forResource: "initialData", withExtension: "json") else {
            print("initialData.json not found")
            return
        }
        
        do {
            // 2. Read the data
            let data = try Data(contentsOf: url)
            
            // 3. Convert to Dictionary
            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // 4. Save to Core Data using the manager
                CoreDataManager.shared.saveDataFromJSON(jsonDict)
            }
            
        } catch {
            print("Failed to load or parse initialData.json: \(error)")
        }
    }
    
    func loadSubscribedArcHistoryData() {
        guard let url = Bundle.main.url(forResource: "subscribed_arc_history", withExtension: "json") else {
            print("subscribed_arc_history.json not found")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            
            if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                CoreDataManager.shared.saveSubscribedArcHistoryFromJSON(jsonDict)
            }
        } catch {
            print("Failed to load or parse subscribed_arc_history.json: \(error)")
        }
    }
}
