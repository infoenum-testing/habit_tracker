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
                    .frame(width: 51, height: 51)
                    .background(Color.ractangleColor)
                    .cornerRadius(9)
                
                Image(habit.icon)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(color)
                
            }
            .frame(width: 51, height: 51)
            
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .center, spacing: 5) {
                    Text(habit.title)
                        .font(Font.sfPro(size: 17, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Text(habit.description)
                        .font(Font.sfPro(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(0)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 11)
        .padding(.trailing, 19)
        .padding(.vertical, 19)
        .frame(maxWidth: .infinity, minHeight: 73, maxHeight: 73, alignment: .leading)
        .background(Color.cellBackgroundColor)
        .cornerRadius(10)
        
    }
}
