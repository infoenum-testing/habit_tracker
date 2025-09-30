////
////  DailyPerformanceGrid.swift
////  HabitTracker
////
////  Created by Mayur Shrivas on 06/09/25.
////

import SwiftUI

struct CompletedArcsGrid: View {
    @EnvironmentObject var appState: AppDataStore

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)

    // ✅ Computed property for unique histories with latest completedAt
    private var uniqueHistories: [(history: History, count: Int)] {
        // 1️⃣ Filter by status
        let filtered = appState.allHistories.filter { history in
            guard let status = history.status else { return false }
            return status == ArcStatus.endByUser.rawValue || status == ArcStatus.lateCompleted.rawValue
        }

        // 2️⃣ Group by arcId (duplicates)
        let grouped = Dictionary(grouping: filtered, by: { $0.arcId ?? "" })

        // 3️⃣ Take the latest completedAt per group + count
        return grouped.compactMap { (_, historiesForArc) -> (History, Int)? in
            // Pick the latest completion date in this group
            guard let latestHistory = historiesForArc.max(by: {
                ($0.completedAt ?? Date.distantPast) < ($1.completedAt ?? Date.distantPast)
            }) else {
                return nil
            }
            return (latestHistory, historiesForArc.count)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Image(StringConstants.Image.trophyIcon)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .scaledToFit()

                Text("Completed Arcs")
                    .font(.sfProDisplay(.semibold, size: 16))
                    .foregroundStyle(.black)
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 8)
            .frame(height: 35, alignment: .center)
            .background(.white)
            .cornerRadius(26)
            .padding(.vertical, 18)

            // Grid of unique histories
            if uniqueHistories.count > 0 {
                // Show grid only if there are completed arcs
                LazyVGrid(columns: columns, spacing: 7) {
                    ForEach(uniqueHistories, id: \.history.id) { (history, count) in
                        let color = ColorToken.from(string: history.color ?? "white")
                        let badgeImage = ColorToken.imageName(from: history.color ?? "white")

                        CompletedArcView(
                            title: history.arcTitle ?? "",
                            days: Int(history.arcDays),
                            date: history.completedAt?.toReadableString() ?? "",
                            icon: badgeImage,
                            iconColor: color,
                            count: count
                        )
                    }
                }
                .padding(.horizontal, 7)
                .padding(.bottom, 18)
            } else {
                EmptyArcCardView()
                    .padding(.vertical, 14).padding(.horizontal, 24)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.cardBackgroundColor)
        .cornerRadius(24)
    }
}
