//
//  DayStripView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 08/09/25.
//

import SwiftUI

struct DayStripView: View {
    let arc: SubscribedArc
    let width: CGFloat = UIScreen.main.bounds.width / 5 - 10
    var arcColor: Color
    var isTaskCompleted: Bool
    
    private var visibleDays: [Int?] {
        let total = arc.wrappedDurationDays
        let current = arc.currentDayIndex
        
        // Always want 5 slots around the current day
        let start = current - 2
        let end = current + 2
        
        return (start...end).map { day in
            (day >= 1 && day <= total) ? day : nil
        }
    }
    
    var body: some View {
        HStack {
            ForEach(Array(visibleDays.enumerated()), id: \.offset) { _, day in
                if let day = day {
                    DayPill(
                        day: day,
                        isSelected: (day == arc.currentDayIndex),
                        isPast: day < arc.currentDayIndex,
                        borderColor: arcColor, isTaskCompleted: isTaskCompleted
                    )
                } else {
                    Color.clear
                        .frame(width: width, height: 90)
                }
            }
        }
    }
}

