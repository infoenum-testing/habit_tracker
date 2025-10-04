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
    @StateObject private var statisticsViewModel = StatisticsViewModel()
    
    
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            OverallScoreCard(statisticsViewModel: statisticsViewModel)
                            CompletedArcsGrid(statisticsViewModel: statisticsViewModel)
                            
                        }
                        .padding(.bottom,10)
                    }.padding(.horizontal,20)
                }.padding(.top,20)
            }
            
            if statisticsViewModel.showInfoPopup {
                VStack {
                    InfoPopupView(statisticsViewModel: statisticsViewModel)
                }                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            appData.refreshStatistics()
            statisticsViewModel.completedArcs = computeCompletedArcs()
        }
        
    }
    
    private func computeCompletedArcs() -> [(history: History, count: Int)] {
        // 1️⃣ Filter completed histories
        let filtered = appData.allHistories.filter { history in
            guard let status = history.status else { return false }
            return status == ArcStatus.endByUser.rawValue || status == ArcStatus.lateCompleted.rawValue
        }

        // 2️⃣ Group by arcId
        let grouped = Dictionary(grouping: filtered, by: { $0.arcId ?? "" })

        // 3️⃣ Take latest per group with count
        var uniqueHistories: [(history: History, count: Int)] = grouped.compactMap { (_, historiesForArc) in
            guard let latest = historiesForArc.max(by: { ($0.completedAt ?? Date.distantPast) < ($1.completedAt ?? Date.distantPast) }) else { return nil }
            return (history: latest, count: historiesForArc.count)
        }

        // 4️⃣ Sort by latest completion date (descending)
        uniqueHistories.sort {
            ($0.history.completedAt ?? Date.distantPast) > ($1.history.completedAt ?? Date.distantPast)
        }

        return uniqueHistories
    }

}

// MARK: - Preview

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
            .preferredColorScheme(.dark)
    }
}
