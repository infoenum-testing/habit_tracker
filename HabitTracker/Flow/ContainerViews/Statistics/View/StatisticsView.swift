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
    private let metrics: [(icon: String, title: String, score: Int, delta: Int)] = [
        ("discipline", "Discipline", 73, 1),
        ("strength", "Strength", 68, 3),
        ("confidence", "Confidence", 70, 3),
        ("intelligence", "Intelligence", 71, 1)
    ]

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(metrics, id: \.title) { metric in
                PerformanceCardView(iconName: metric.icon,
                                    title: metric.title,
                                    score: metric.score,
                                    delta: metric.delta)
            }
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
