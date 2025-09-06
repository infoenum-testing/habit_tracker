//
//  StatisticsView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 20/08/25.
//

import SwiftUI
import Foundation

struct StatisticsView: View {
    @EnvironmentObject var appData: AppDataStore
    var body: some View {
        VStack {
            HeaderView()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    OverallScoreCard()
                    
                    SectionTitle("Daily Performance")
                    
                    DailyPerformanceGrid()
                    
                    SectionTitle("Weekly Performance")
                    
                    WeeklyPerformanceSection()
                }
                .padding(.horizontal, 16)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            appData.refreshStatistics()
        }
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
