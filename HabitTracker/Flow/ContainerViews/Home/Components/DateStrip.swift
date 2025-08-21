//
//  DateStrip.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct DateStrip: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                let days = state.selectedDate.fiveDayWindow()

                HStack(spacing: 10) {
                    // leading spacer so that the mid element sits in center
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width / 2 - 30)

                    ForEach(Array(days.enumerated()), id: \.element) { index, day in
                        DatePill(date: day,
                                 isSelected: day == state.selectedDate,
                                 isPast: day < state.selectedDate.stripTime())
                            .id(index)
                    }
                    Spacer()
                        .frame(width: UIScreen.main.bounds.width / 2 - 30)
                }
                .padding(.vertical, 10)
            }.scrollDisabled(true)
            .onAppear {
                // Scroll to the middle element
                let days = state.selectedDate.fiveDayWindow()
                let midIndex = days.count / 2
                proxy.scrollTo(midIndex, anchor: .center)
            }
        }
    }
}
