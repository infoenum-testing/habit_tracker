//
//  DatePill.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 14/08/25.
//

import Foundation
import SwiftUI

struct DatePill: View {
    @EnvironmentObject var state: AppState
   
   @State var days : [Date] = []
    let date: Date
    let isSelected: Bool
    let isPast: Bool
    var body: some View {
        
        VStack(spacing: 2) {
            Text(date.dayString())
                .font(.sfProDisplay(.bold, size: 28))
                .foregroundColor(isSelected ? .white : .appGray)
            Text(date.weekdayShort())
                .font(.sfProDisplay(.bold, size: 14))
                .foregroundColor(isSelected ? .white : .appGray)
            if isSelected {
                    VStack(spacing: 1) {
                        ForEach(Array(state.activeArcs.prefix(3)).indices, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 2)
                                .fill(state.activeArcs[i].color)
                                .frame(width: 18, height: 4)
                        }
                    }
                    .padding(2)
            }
        }
        .foregroundStyle(.white)
        .frame(width: 70, height: 90)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 25).stroke(isSelected ? .white : .appGray , lineWidth: isSelected ? 2 : 1)
            }
        )
        .onAppear {
             days = state.selectedDate.fiveDayWindow()
        }
    }
}
