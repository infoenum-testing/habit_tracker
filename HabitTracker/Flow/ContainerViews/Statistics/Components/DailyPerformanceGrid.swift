//
//  DailyPerformanceGrid.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import SwiftUI

struct DailyPerformanceGrid: View {
    @EnvironmentObject var appData: AppDataStore

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

    var body: some View {
        if let stats = appData.todayStatistics {
            LazyVGrid(columns: columns, spacing: 16) {
                PerformanceCardView(
                    iconName: "discipline",
                    title: "Discipline",
                    score: Int(appData.grandTotals.discipline),
                    delta: Int(stats.disciplineDelta)
                )
                PerformanceCardView(
                    iconName: "strength",
                    title: "Strength",
                    score: Int(appData.grandTotals.strength),
                    delta: Int(stats.strengthDelta)
                )
                PerformanceCardView(
                    iconName: "confidence",
                    title: "Confidence",
                    score: Int(appData.grandTotals.confidence),
                    delta: Int(stats.confidenceDelta)
                )
                PerformanceCardView(
                    iconName: "intelligence",
                    title: "Intelligence",
                    score: Int(appData.grandTotals.intelligence),
                    delta: Int(stats.intelligenceDelta)
                )
            }
        } else {
            Text("No statistics yet")
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    DailyPerformanceGrid()
}
