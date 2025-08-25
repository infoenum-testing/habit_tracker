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
    
    init() {
            // Print all available fonts
            for family in UIFont.familyNames.sorted() {
                print("Family: \(family)")
                for name in UIFont.fontNames(forFamilyName: family).sorted() {
                    print("   \(name)")
                }
            }
        }
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(state)
                .preferredColorScheme(.dark)
        }
    }
}
