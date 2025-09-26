//
//  DailyHabitsCellView.swift
//  HabitTracker
//
//  Created by Mayur Shrivas on 26/08/25.
//

import SwiftUI

struct ArcDailyHabitsCellView: View {
    let habit: HabitData
    var color: Color
    var body: some View {
        
        HStack(alignment: .center, spacing: 10){
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 42, height: 42)
                    .background(Color.customBlack)
                    .cornerRadius(9)
                
                Image(habit.icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(color)
                
            }
            .frame(width: 42, height: 42)
            
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .center, spacing: 5) {
                    Text(habit.title)
                        .font(Font.sfPro(size: 14, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Text(habit.description)
                        .font(Font.sfPro(size: 12))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .leading)
        .background(Color.customBlack)
        .cornerRadius(18)
        
    }
}
