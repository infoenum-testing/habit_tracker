//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import SwiftUI

@main
struct HabitTrackerApp: App {
    @StateObject private var appState = AppDataStore()
    @StateObject private var router = NavigationRouter()
    @AppStorage("isInitialDataSaved") var isInitialDataSaved: Bool = false
    init() {
        if !isInitialDataSaved {
            InitialDataLoader.shared.loadInitialData()
        }
    }
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(router)
                .environmentObject(appState)
                .preferredColorScheme(.dark)
        }
    }
}


