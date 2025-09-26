//
//  DayPill.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 22/08/25.
//

import Foundation
import SwiftUI

struct DayPill: View {
    
    var day: Int = 1
    let isSelected: Bool
    let isPast: Bool
    let width: CGFloat = UIScreen.main.bounds.width / 5 - 10
    var borderColor = Color.white
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
        .frame(width: width, height: 90)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 25).stroke(isSelected ? borderColor : .white.opacity(0.7) , lineWidth: isSelected ? 2 : 1)
            }
        )
    }
}
