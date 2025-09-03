//
//  StatisticsView.swift
//  HabitTracker
//
//  Created by IE14 on 20/08/25.
//

import SwiftUI
import Foundation

struct StatisticsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HeaderView()

                OverallScoreCard()

                SectionTitle("Daily Performance")

                DailyPerformanceGrid()
                
                SectionTitle("Weekly Performance")

                WeeklyPerformanceSection()
            }
            .padding(.horizontal, 16)
        }
        .background(Color.black.ignoresSafeArea())
    }
}

// MARK: - Components

private struct HeaderView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Statistics")
                .font(.sfProDisplay(.semibold, size: 22))
            Spacer()
        }
    }
}

private struct SectionTitle: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.sfProDisplay(.medium, size: 16))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct DailyPerformanceGrid: View {
    @EnvironmentObject var state: AppDataStore

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

    var body: some View {
        if let stats = state.todayStatistics {
            LazyVGrid(columns: columns, spacing: 16) {
                PerformanceCardView(
                    iconName: "discipline",
                    title: "Discipline",
                    score: Int(stats.disciplineTotal),
                    delta: Int(stats.disciplineDelta)
                )
                PerformanceCardView(
                    iconName: "strength",
                    title: "Strength",
                    score: Int(stats.strengthTotal),
                    delta: Int(stats.strengthDelta)
                )
                PerformanceCardView(
                    iconName: "confidence",
                    title: "Confidence",
                    score: Int(stats.confidenceTotal),
                    delta: Int(stats.confidenceDelta)
                )
                PerformanceCardView(
                    iconName: "intelligence",
                    title: "Intelligence",
                    score: Int(stats.intelligenceTotal),
                    delta: Int(stats.intelligenceDelta)
                )
            }
        } else {
            Text("No statistics yet")
                .foregroundColor(.gray)
        }
    }
}

private struct WeeklyPerformanceSection: View {
    var body: some View {
        VStack {
            WeeklyBarsCard()
        }
        .padding(5)
        .background(Color.statsBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.appGray, lineWidth: 1.5)
        )
    }
}

// MARK: - Preview

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
            .preferredColorScheme(.dark)
    }
}
