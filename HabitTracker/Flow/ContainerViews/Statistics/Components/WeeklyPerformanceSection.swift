//
//  WeeklyPerformanceSection.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 06/09/25.
//

import SwiftUI

struct WeeklyPerformanceSection: View {
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

#Preview {
    WeeklyPerformanceSection()
}
