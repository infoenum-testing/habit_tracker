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
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Spacer()
                    Text("Statistics")
                        .font(.sfProDisplay(.semibold, size: 22))
                    Spacer()
                }

                // Overall Score Card
                OverallScoreCard()

                // Daily Performance
                Text("Daily Performance")
                    .font(.sfProDisplay(.medium, size: 16))
                    

                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 16) {
                    PerformanceCardView(iconName: "discipline",
                                        title: "Discipline",
                                        score: 73,
                                        delta: 1)
                    PerformanceCardView(iconName: "strength",
                                        title: "Strength",
                                        score: 68,
                                        delta: 3)
                    PerformanceCardView(iconName: "confidence",
                                        title: "Confidence",
                                        score: 70,
                                        delta: 3)
                    PerformanceCardView(iconName: "intelligence",
                                        title: "Intelligence",
                                        score: 71,
                                        delta: 1)
                }
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
            .padding(.horizontal, 16)
        }
        .background(Color.black.ignoresSafeArea())
    }
}


struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
            .preferredColorScheme(.dark)
    }
}



