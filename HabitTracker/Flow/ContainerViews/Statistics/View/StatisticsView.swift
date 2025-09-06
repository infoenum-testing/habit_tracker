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

// MARK: - Preview

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
            .preferredColorScheme(.dark)
    }
}
