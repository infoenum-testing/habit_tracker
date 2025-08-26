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
    @StateObject private var router = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(state)
                .environmentObject(router)
                .preferredColorScheme(.dark)
        }
    }
}
