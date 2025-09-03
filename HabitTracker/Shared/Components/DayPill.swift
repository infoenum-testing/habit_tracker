//
//  DayPill.swift
//  HabitTracker
//
//  Created by IE14 on 22/08/25.
//

import Foundation
import SwiftUI

struct DayPill: View {
    //@EnvironmentObject var state: AppState
   
   //@State var days : [Date] = []
    var day: Int = 1
    let isSelected: Bool
    let isPast: Bool
    var body: some View {
        
        VStack(spacing: 2) {
            Text("DAY")
                .font(.sfProDisplay(.bold, size: 13))
                .foregroundColor(isSelected ? .white : .white.opacity(0.5))
            Text("\(day)")
                .font(.sfProDisplay(.bold, size: 28))
                .foregroundColor(isSelected ? .white : .white.opacity(0.5))
        }
        .foregroundStyle(.white)
        .frame(width: 70, height: 90)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 25).stroke(isSelected ? .white : .white.opacity(0.7) , lineWidth: isSelected ? 2 : 1)
            }
        )
        .onAppear {
            // days = state.selectedDate.fiveDayWindow()
        }
    }
}
