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
                    iconName: StringConstants.Image.discipline,
                    title: StringConstants.Statistic.discipline,
                    score: Int(appData.grandTotals.discipline),
                    delta: Int(stats.disciplineDelta)
                )
                PerformanceCardView(
                    iconName: StringConstants.Image.strength,
                    title: StringConstants.Statistic.strength,
                    score: Int(appData.grandTotals.strength),
                    delta: Int(stats.strengthDelta)
                )
                PerformanceCardView(
                    iconName: StringConstants.Image.confidence,
                    title: StringConstants.Statistic.confidence,
                    score: Int(appData.grandTotals.confidence),
                    delta: Int(stats.confidenceDelta)
                )
                PerformanceCardView(
                    iconName: StringConstants.Image.intelligence,
                    title: StringConstants.Statistic.intelligence,
                    score: Int(appData.grandTotals.intelligence),
                    delta: Int(stats.intelligenceDelta)
                )
            }
        } else {
            Text(StringConstants.Statistic.noStatistics)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    DailyPerformanceGrid()
}
