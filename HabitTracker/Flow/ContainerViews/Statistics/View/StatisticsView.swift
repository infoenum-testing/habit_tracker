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
            VStack {
            HeaderView()
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    OverallScoreCard()
                    
                    SectionTitle(StringConstants.Statistic.dailyPerformance)
                    
                    DailyPerformanceGrid()
                    
                    SectionTitle(StringConstants.Statistic.weeklyPerformance)
                    
                    WeeklyPerformanceSection()
                }
                .padding(.bottom,10)
            }.padding(.horizontal,20)
        }
            .padding(.top,20)
            .edgesIgnoringSafeArea(.bottom)
            .background(Color.sheetBackground)
            .cornerRadius(36, corners: [.topLeft, .topRight])
           
               
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
