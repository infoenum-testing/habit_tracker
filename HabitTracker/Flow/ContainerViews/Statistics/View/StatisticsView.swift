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
    @State private var showInfoPopup: Bool = false
    
    var body: some View {
        VStack {
            VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    
                    OverallScoreCard(showInfoPopup: $showInfoPopup)
                    
                    CompletedArcsGrid()
                    
                }
                .padding(.bottom,10)
            }.padding(.horizontal,20)
        }.padding(.top,20)
        }
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            appData.refreshStatistics()
        }
        .overlay {
            if showInfoPopup {
                InfoPopupView(showInfoPopup: $showInfoPopup)
            }
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
